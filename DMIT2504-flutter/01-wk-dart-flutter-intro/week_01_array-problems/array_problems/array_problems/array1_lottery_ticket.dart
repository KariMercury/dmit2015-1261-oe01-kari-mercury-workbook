// Array Problem 1 - Lottery Ticket Generator
// Run with:  dart run array_problems/array1_lottery_ticket.dart
//
// The user enters how many numbers are in the pick and the top of the
// range (1..range). The numbers are stored in a fixed-length array with
// no duplicates. The values are not sorted.

import 'dart:io';
import 'dart:math';

/// Keeps prompting until the user enters a whole number of at least [min].
/// `min` is a named parameter with a default of 0. Here every call passes
/// `min: 1` because a pick of zero numbers makes no sense.
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
  print('=== Lottery Ticket Generator ===');

  int count = readPositiveInt('How many numbers in the pick? ', min: 1);
  int range = readPositiveInt('Enter the top of the range (1-?): ', min: 1);

  // A pick of 6 unique numbers is impossible if the range is only 1-5.
  while (range < count) {
    print('  The range must be at least $count to avoid duplicates.');
    range = readPositiveInt('Enter the top of the range (1-?): ', min: 1);
  }

  // Fixed-length array to hold the pick.
  List<int> pick = List<int>.filled(count, 0);
  Random random = Random();

  int filled = 0;
  while (filled < count) {
    // Random number from 1 to range inclusive.
    int candidate = random.nextInt(range) + 1;

    // Check the values already stored for a duplicate.
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

  print('');
  print('Your lottery pick:');
  print(pick.join(' '));
}
