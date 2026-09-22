import 'dart:convert';
import 'dart:io';

import 'package:dictionary_lookup/dictionary_service.dart';
import 'package:dictionary_lookup/word_definition.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  final fixture = File('test/fixture_vernacular.json').readAsStringSync();

  group('WordDefinition.fromJson', () {
    test('pulls the first definition out of the real API shape', () {
      final d = WordDefinition.fromJson(jsonDecode(fixture));
      expect(d.word, 'vernacular');
      expect(d.partOfSpeech, 'noun');
      expect(d.definition, 'The language of a people or a national language.');
      expect(d.example, contains('New Zealand'));
    });

    test('round-trips through toJson', () {
      final d = WordDefinition.fromJson(jsonDecode(fixture));
      final copy = jsonDecode(jsonEncode(d.toJson()));
      expect(copy['word'], 'vernacular');
      expect(copy['definition'], d.definition);
    });

    test('throws FormatException on an empty list', () {
      expect(() => WordDefinition.fromJson([]), throwsFormatException);
    });

    test('throws FormatException when meanings are missing', () {
      expect(
          () => WordDefinition.fromJson([
                {'word': 'x'}
              ]),
          throwsFormatException);
    });
  });

  group('DictionaryService.lookup', () {
    DictionaryService serviceReturning(int status, String body) =>
        DictionaryService(
          client: MockClient((_) async => http.Response(body, status,
              headers: {'content-type': 'application/json; charset=utf-8'})),
        );

    test('200 -> WordDefinition', () async {
      final d = await serviceReturning(200, fixture).lookup('Vernacular');
      expect(d.word, 'vernacular');
    });

    test('404 -> DictionaryException with API message', () async {
      const body404 =
          '{"title":"No Definitions Found","message":"Sorry pal, we could not find definitions for the word you were looking for.","resolution":"..."}';
      expect(
        () => serviceReturning(404, body404).lookup('asdfqwerty'),
        throwsA(isA<DictionaryException>()
            .having((e) => e.statusCode, 'statusCode', 404)
            .having((e) => e.message, 'message', contains('Sorry pal'))),
      );
    });

    test('522 -> DictionaryException with status', () async {
      expect(
        () => serviceReturning(522, 'error code: 522').lookup('vernacular'),
        throwsA(isA<DictionaryException>()
            .having((e) => e.statusCode, 'statusCode', 522)),
      );
    });

    test('200 with garbage body -> DictionaryException (parse)', () async {
      expect(
        () => serviceReturning(200, 'this is not json').lookup('vernacular'),
        throwsA(isA<DictionaryException>()
            .having((e) => e.message, 'message', contains('parse'))),
      );
    });

    test('empty input -> DictionaryException', () async {
      expect(() => serviceReturning(200, fixture).lookup('   '),
          throwsA(isA<DictionaryException>()));
    });
  });
}
