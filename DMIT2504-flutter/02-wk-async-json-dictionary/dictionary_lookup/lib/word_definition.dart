/// Model class for the data we care about from dictionaryapi.dev.
///
/// The API returns a LOT more than this (phonetics, synonyms, licence,
/// source URLs...). A model class lets us pick out ONLY what the app needs
/// and gives the rest of the program a typed object instead of `dynamic`.
class WordDefinition {
  final String word;
  final String partOfSpeech;
  final String definition;
  final String? example;

  const WordDefinition({
    required this.word,
    required this.partOfSpeech,
    required this.definition,
    this.example,
  });

  /// Build a [WordDefinition] from the FIRST entry / FIRST meaning /
  /// FIRST definition in the decoded JSON.
  ///
  /// `json` is the decoded top-level value from `jsonDecode`, which for this
  /// endpoint is a `List` of entry objects.
  ///
  /// Throws [FormatException] if the shape isn't what we expect. Failing
  /// loudly here is better than letting a null leak into the UI later.
  factory WordDefinition.fromJson(dynamic json) {
    if (json is! List || json.isEmpty) {
      throw const FormatException('Expected a non-empty list of entries.');
    }

    final entry = json.first;
    if (entry is! Map<String, dynamic>) {
      throw const FormatException('Entry was not a JSON object.');
    }

    final meanings = entry['meanings'];
    if (meanings is! List || meanings.isEmpty) {
      throw const FormatException('Entry had no meanings.');
    }

    final meaning = meanings.first as Map<String, dynamic>;
    final definitions = meaning['definitions'];
    if (definitions is! List || definitions.isEmpty) {
      throw const FormatException('Meaning had no definitions.');
    }

    final def = definitions.first as Map<String, dynamic>;

    return WordDefinition(
      word: entry['word'] as String,
      partOfSpeech: meaning['partOfSpeech'] as String? ?? 'unknown',
      definition: def['definition'] as String,
      example: def['example'] as String?,
    );
  }

  /// Serialise back to JSON (the "to" side of "to and from JSON").
  Map<String, dynamic> toJson() => {
        'word': word,
        'partOfSpeech': partOfSpeech,
        'definition': definition,
        if (example != null) 'example': example,
      };

  @override
  String toString() => '$word ($partOfSpeech): $definition';
}
