// Array Problem 2 - Multiple Lottery Picks with QuickPick()
// Run with:  dart run array_problems/array2_quick_pick.dart
//
// Extends Array Problem 1 so the user can choose how many picks they want.
// QuickPick(int[] pick, int range) fills the array with unique random
// values. The array length decides how many numbers are in the pick, and
// because arrays are passed by reference nothing needs to be returned.

import 'dart:io';
import 'dart:math';

/// Fills [pick] with unique random numbers from 1 to [range] inclusive.
/// The number of values generated is pick.length.
///
/// Both parameters are required positional parameters, matching the
/// assignment signature `static void QuickPick(int[] pick, int range)`.
/// A List is a reference type, so changes made to `pick` inside this method
/// are visible to the caller - that is why the return type is void.
void QuickPick(List<int> pick, int range) {
  Random random = Random();
  int filled = 0;

  while (filled < pick.length) {
    int candidate = random.nextInt(range) + 1;

    bool isDuplicate = false;
    for (int i = 0; i < filled; i++) {
      if (pick[i] == candidate) {
        isDuplicate = true;
        break;
      }
    }

    if (!isDuplicate) {
      pick[filled] = candidate;
      filled++;
    }
  }
}

/// Keeps prompting until the user enters a whole number of at least [min].
/// `min` is a named parameter with a default of 0. Here every call passes
/// `min: 1`.
///
/// Null safety: readLineSync() gives String? (null when input has ended, e.g.
/// Ctrl+Z) and int.tryParse() gives int? (null when the text is not a whole
/// number). Each `== null` check lets Dart promote the variable to its
/// non-nullable type for the code that follows.
/// See notes/null_safety.dart for a full walkthrough.
int readPositiveInt(String prompt, {int min = 0}) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();

    if (input == null) {
      print('\nNo more input - exiting.');
      exit(1);
    }

    int? value = int.tryParse(input);

    if (value == null) {
      print('  Invalid input. Please enter a whole number.');
    } else if (value < 0) {
      print('  Negative values are not allowed. Please try again.');
    } else if (value < min) {
      print('  Value must be at least $min. Please try again.');
    } else {
      return value;
    }
  }
}

void main() {
  print('=== Lottery Quick Pick ===');

  int numberOfPicks = readPositiveInt('How many picks would you like? ', min: 1);
  int count = readPositiveInt('How many numbers in each pick?  ', min: 1);
  int range = readPositiveInt('Enter the top of the range (1-?): ', min: 1);

  while (range < count) {
    print('  The range must be at least $count to avoid duplicates.');
    range = readPositiveInt('Enter the top of the range (1-?): ', min: 1);
  }

  print('');
  for (int p = 1; p <= numberOfPicks; p++) {
    List<int> pick = List<int>.filled(count, 0);
    QuickPick(pick, range);
    print('Pick $p: ${pick.join(' ')}');
  }
}
