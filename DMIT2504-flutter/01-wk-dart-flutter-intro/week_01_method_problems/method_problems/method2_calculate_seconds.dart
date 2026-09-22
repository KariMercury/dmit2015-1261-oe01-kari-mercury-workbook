// Method Problem 2 - Hours/Minutes/Seconds to Seconds
// Run with:  dart run method_problems/method2_calculate_seconds.dart
//
// CalculateSeconds() receives hours, minutes and seconds and returns the
// total number of seconds.

import 'dart:io';

/// Converts hours, minutes and seconds into a total number of seconds.
int CalculateSeconds(int hours, int minutes, int seconds) {
  const int secondsPerMinute = 60;
  const int secondsPerHour = 60 * secondsPerMinute;

  return (hours * secondsPerHour) + (minutes * secondsPerMinute) + seconds;
}

/// Keeps prompting until the user enters a whole number of at least [min].
/// `min` is a named parameter with a default of 0.
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
  print('=== Time to Seconds Converter ===');

  int hours = readPositiveInt('Enter hours:   ');
  int minutes = readPositiveInt('Enter minutes: ');
  int seconds = readPositiveInt('Enter seconds: ');

  int total = CalculateSeconds(hours, minutes, seconds);

  print('');
  print('$hours h, $minutes m, $seconds s = $total seconds');
}
