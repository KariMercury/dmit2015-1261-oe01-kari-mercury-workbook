// DMIT 2504 · Week 1 — Dart Part 2 exercise SOLUTIONS (instructor copy).
// Run: dart run exercises/solutions.dart
//
// One possible answer per exercise. Many others are equally correct —
// mark on whether the constraints were respected, not on matching this file.

// ============================================================ WARM-UP

/// 1 · FizzBuzz as a FUNCTION that RETURNS a String (it must not print).
String fizzBuzz(int n) {
  if (n % 15 == 0) return 'FizzBuzz';
  if (n % 3 == 0) return 'Fizz';
  if (n % 5 == 0) return 'Buzz';
  return '$n';
}

/// 2 · Sum a List<int> with fold — no loop, no reduce.
int sumOf(List<int> values) => values.fold(0, (total, v) => total + v);

/// 3 · Reverse a String without using .reversed.
String reverse(String s) {
  var out = '';
  for (var i = s.length - 1; i >= 0; i--) {
    out += s[i];
  }
  return out;
}

/// 4 · Count words, tolerating extra spaces.
int wordCount(String sentence) =>
    sentence.split(' ').where((w) => w.isNotEmpty).length;

/// 5 · Convert a List<String> of digits into a List<int>.
/// int.tryParse returns int? — so this is a null-safety exercise in disguise.
List<int> toInts(List<String> digits) =>
    digits.map(int.tryParse).whereType<int>().toList();

// ============================================================ CORE

/// 6 · Median. The even-count case is the whole exercise.
double median(List<int> values) {
  if (values.isEmpty) return 0;
  final sorted = [...values]..sort(); // copy: never mutate the caller's list
  final mid = sorted.length ~/ 2;
  return sorted.length.isOdd
      ? sorted[mid].toDouble()
      : (sorted[mid - 1] + sorted[mid]) / 2;
}

/// 7 · Initials, with a named parameter that has a default.
String initials(String fullName, {bool dots = true}) {
  final letters = fullName
      .split(' ')
      .where((part) => part.isNotEmpty)
      .map((part) => part[0].toUpperCase());
  return dots ? '${letters.join('.')}.' : letters.join();
}

/// 8 · A class with a nullable field, sorted so unknowns come last.
class Book {
  final String title;
  final String author;
  final int? year; // null = publication year unknown

  Book({required this.title, required this.author, this.year});

  @override
  String toString() => '$title (${year ?? 'unknown'})';
}

List<Book> byYearUnknownsLast(List<Book> books) {
  return [...books]..sort((a, b) {
    final ay = a.year, by = b.year;
    if (ay == null && by == null) return a.title.compareTo(b.title);
    if (ay == null) return 1; // a sinks
    if (by == null) return -1; // b sinks
    return ay.compareTo(by);
  });
}

/// 9 · Divide without throwing. Returning double? says "this may fail".
double? safeDivide(int a, int b) => b == 0 ? null : a / b;

// ============================================================ STRETCH

class Song {
  final String title;
  final int seconds;

  Song({required this.title, required this.seconds});

  @override
  String toString() => '$title (${_mmss(seconds)})';
}

class Playlist {
  final String name;
  final List<Song> songs;

  Playlist({required this.name, List<Song>? songs}) : songs = songs ?? [];

  int get totalSeconds => songs.fold(0, (total, s) => total + s.seconds);

  String get totalDuration => _mmss(totalSeconds);

  /// Nullable return: an empty playlist has no longest song.
  Song? get longest {
    if (songs.isEmpty) return null;
    return songs.reduce((a, b) => b.seconds > a.seconds ? b : a);
  }

  void add(Song s) => songs.add(s);

  @override
  String toString() => '$name · ${songs.length} songs · $totalDuration';
}

String _mmss(int seconds) {
  final m = seconds ~/ 60;
  final s = (seconds % 60).toString().padLeft(2, '0');
  return '$m:$s';
}

// ============================================================ SELF-CHECK

int _passed = 0, _failed = 0;

void check(String label, Object? actual, Object? expected) {
  if (actual.toString() == expected.toString()) {
    _passed++;
    print('  ok   $label');
  } else {
    _failed++;
    print('  FAIL $label → got "$actual", expected "$expected"');
  }
}

void main() {
  print('WARM-UP');
  check('fizzBuzz(3)', fizzBuzz(3), 'Fizz');
  check('fizzBuzz(5)', fizzBuzz(5), 'Buzz');
  check('fizzBuzz(15)', fizzBuzz(15), 'FizzBuzz');
  check('fizzBuzz(7)', fizzBuzz(7), '7');
  check('sumOf([1,2,3])', sumOf([1, 2, 3]), 6);
  check('sumOf([])', sumOf([]), 0);
  check('reverse("Dart")', reverse('Dart'), 'traD');
  check('wordCount', wordCount('the  quick brown fox'), 4);
  check('toInts', toInts(['1', '2', 'x', '3']), [1, 2, 3]);

  print('\nCORE');
  check('median odd', median([3, 1, 2]), 2.0);
  check('median even', median([1, 2, 3, 4]), 2.5);
  check('median empty', median([]), 0.0);
  check('initials dots', initials('ana maria lopez'), 'A.M.L.');
  check('initials no dots', initials('ana maria lopez', dots: false), 'AML');
  check('safeDivide ok', safeDivide(7, 2), 3.5);
  check('safeDivide by zero', safeDivide(7, 0), null);

  final books = [
    Book(title: 'Zeta', author: 'A', year: null),
    Book(title: 'Beta', author: 'B', year: 1999),
    Book(title: 'Alpha', author: 'C', year: 1965),
    Book(title: 'Omega', author: 'D', year: null),
  ];
  check('books sorted', byYearUnknownsLast(books),
      '[Alpha (1965), Beta (1999), Omega (unknown), Zeta (unknown)]');

  print('\nSTRETCH');
  final pl = Playlist(name: 'Lab tunes', songs: [
    Song(title: 'One', seconds: 200),
    Song(title: 'Two', seconds: 95),
  ]);
  pl.add(Song(title: 'Three', seconds: 61));
  check('totalDuration', pl.totalDuration, '5:56');
  check('longest', pl.longest, 'One (3:20)');
  check('empty longest', Playlist(name: 'Empty').longest, null);

  print('\n$_passed passed, $_failed failed');
}
