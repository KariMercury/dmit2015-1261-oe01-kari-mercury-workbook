// DMIT 2504 · Week 1 — Dart Part 2 exercises (STARTER).
// Run: dart run exercises/starter.dart
//
// Every exercise below currently throws. Replace each body with real code and
// re-run: the self-check at the bottom turns FAIL into ok as you go.
// Rules for all of them:
//   · explicit return types — no bare functions, no dynamic
//   · functions RETURN values; only main() and the checker print
//   · no ! operator (except with a comment explaining why it is safe)

// ============================================================ WARM-UP

/// 1 · Return 'Fizz' for multiples of 3, 'Buzz' for 5, 'FizzBuzz' for both,
///     otherwise the number as a String. Do not print anything.
String fizzBuzz(int n) {
  throw UnimplementedError('exercise 1');
}

/// 2 · Add up the list using fold. No for loop, no reduce.
int sumOf(List<int> values) {
  throw UnimplementedError('exercise 2');
}

/// 3 · Reverse the string. You may not use .reversed.
String reverse(String s) {
  throw UnimplementedError('exercise 3');
}

/// 4 · Count the words. 'the  quick brown fox' has 4, not 5.
int wordCount(String sentence) {
  throw UnimplementedError('exercise 4');
}

/// 5 · Turn ['1','2','x','3'] into [1, 2, 3].
///     Hint: int.tryParse returns int?, and whereType<int>() drops nulls.
List<int> toInts(List<String> digits) {
  throw UnimplementedError('exercise 5');
}

// ============================================================ CORE

/// 6 · The middle value. With an even count, average the middle two.
///     Return 0 for an empty list, and do not reorder the caller's list.
double median(List<int> values) {
  throw UnimplementedError('exercise 6');
}

/// 7 · 'ana maria lopez' -> 'A.M.L.'  and with dots: false -> 'AML'.
String initials(String fullName, {bool dots = true}) {
  throw UnimplementedError('exercise 7');
}

/// 8 · A Book with an unknown publication year. Decide for yourself which of
///     the four field strategies fits each field (required / default /
///     nullable / late) before you write the constructor.
class Book {
  // TODO: fields — title, author, year (year may be unknown)

  Book({required String title, required String author, int? year}) {
    throw UnimplementedError('exercise 8: fields and constructor');
  }

  @override
  String toString() => throw UnimplementedError('exercise 8: toString');
}

/// 8b · Sort by year ascending, with unknown years last. Return a NEW list.
List<Book> byYearUnknownsLast(List<Book> books) {
  throw UnimplementedError('exercise 8b');
}

/// 9 · Divide without throwing and without crashing. What should the return
///     type be if b might be zero?
double? safeDivide(int a, int b) {
  throw UnimplementedError('exercise 9');
}

// ============================================================ STRETCH
//
// 10 · Playlist holding a List<Song>, with:
//        · a totalDuration getter formatted as m:ss
//        · a longest getter — what should it return for an empty playlist?
//      Write the classes yourself, then add checks for them below.
//
// 11 · The capstone grade tracker (see the slides), reading marks from stdin
//      instead of hard-coding them. Start from bin/14_grade_tracker.dart.

// ============================================================ SELF-CHECK

int _passed = 0, _failed = 0;

void check(String label, Object? Function() run, Object? expected) {
  Object? actual;
  try {
    actual = run();
  } catch (e) {
    _failed++;
    print('  FAIL $label → not implemented');
    return;
  }
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
  check('fizzBuzz(3)', () => fizzBuzz(3), 'Fizz');
  check('fizzBuzz(5)', () => fizzBuzz(5), 'Buzz');
  check('fizzBuzz(15)', () => fizzBuzz(15), 'FizzBuzz');
  check('fizzBuzz(7)', () => fizzBuzz(7), '7');
  check('sumOf([1,2,3])', () => sumOf([1, 2, 3]), 6);
  check('sumOf([])', () => sumOf([]), 0);
  check('reverse("Dart")', () => reverse('Dart'), 'traD');
  check('wordCount', () => wordCount('the  quick brown fox'), 4);
  check('toInts', () => toInts(['1', '2', 'x', '3']), [1, 2, 3]);

  print('\nCORE');
  check('median odd', () => median([3, 1, 2]), 2.0);
  check('median even', () => median([1, 2, 3, 4]), 2.5);
  check('median empty', () => median([]), 0.0);
  check('initials dots', () => initials('ana maria lopez'), 'A.M.L.');
  check('initials no dots',
      () => initials('ana maria lopez', dots: false), 'AML');
  check('safeDivide ok', () => safeDivide(7, 2), 3.5);
  check('safeDivide by zero', () => safeDivide(7, 0), null);
  check('books sorted', () {
    final books = [
      Book(title: 'Zeta', author: 'A'),
      Book(title: 'Beta', author: 'B', year: 1999),
      Book(title: 'Alpha', author: 'C', year: 1965),
      Book(title: 'Omega', author: 'D'),
    ];
    return byYearUnknownsLast(books);
  }, '[Alpha (1965), Beta (1999), Omega (unknown), Zeta (unknown)]');

  print('\n$_passed passed, $_failed to go');
}
