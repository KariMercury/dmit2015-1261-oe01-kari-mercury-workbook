import 'dart:convert';

import 'package:http/http.dart' as http;

import 'word_definition.dart';

/// Thrown when the dictionary API cannot give us a usable definition.
///
/// A custom exception type lets the UI layer (bin/main.dart) tell the
/// difference between "the word doesn't exist" and "the network exploded"
/// and show the user a sensible message for each.
class DictionaryException implements Exception {
  final String message;
  final int? statusCode;

  const DictionaryException(this.message, {this.statusCode});

  @override
  String toString() => statusCode == null
      ? 'DictionaryException: $message'
      : 'DictionaryException ($statusCode): $message';
}

/// Talks to https://dictionaryapi.dev/ and converts the response into a
/// [WordDefinition].
class DictionaryService {
  static const String _baseUrl =
      'https://api.dictionaryapi.dev/api/v2/entries/en/';

  /// The http client is injected so tests can pass a fake one.
  final http.Client _client;

  DictionaryService({http.Client? client}) : _client = client ?? http.Client();

  /// Look up [word] and return its first definition.
  ///
  /// This is an `async` function so it returns a `Future<WordDefinition>`.
  /// The caller `await`s it; nothing here blocks the program.
  Future<WordDefinition> lookup(String word) async {
    final cleaned = word.trim().toLowerCase();
    if (cleaned.isEmpty) {
      throw const DictionaryException('Please enter a word.');
    }

    // 1. Build the URL by appending the word to the endpoint.
    //    Uri.encodeComponent handles spaces / punctuation safely.
    final uri = Uri.parse('$_baseUrl${Uri.encodeComponent(cleaned)}');

    // 2. Send the request. `await` suspends THIS function only.
    final http.Response response;
    try {
      response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 10)); // don't hang forever
    } on Exception catch (e) {
      // SocketException (no internet), TimeoutException, ClientException...
      throw DictionaryException('Network error: $e');
    }

    // 3. FAILURE TYPE 1 - the server answered, but not with 200.
    if (response.statusCode == 404) {
      // dictionaryapi.dev returns a JSON object with a friendly message
      // on 404, so we can surface that instead of a generic error.
      final body = _tryDecode(response.body);
      final msg = body is Map ? body['message'] : null;
      throw DictionaryException(
        msg is String ? msg : 'No definitions found for "$cleaned".',
        statusCode: 404,
      );
    }
    if (response.statusCode != 200) {
      throw DictionaryException(
        'Server returned an unexpected status.',
        statusCode: response.statusCode,
      );
    }

    // 4. FAILURE TYPE 2 - status is 200 but the body isn't what we expect.
    //    jsonDecode throws FormatException on bad JSON; fromJson throws
    //    FormatException if the shape is wrong. We convert both to our
    //    own exception type so main.dart only has one thing to catch.
    try {
      final decoded = jsonDecode(response.body);
      return WordDefinition.fromJson(decoded);
    } on FormatException catch (e) {
      throw DictionaryException('Could not parse response: ${e.message}');
    }
  }

  /// Decode without throwing; used only for the 404 error body.
  static dynamic _tryDecode(String body) {
    try {
      return jsonDecode(body);
    } on FormatException {
      return null;
    }
  }

  void close() => _client.close();
}
