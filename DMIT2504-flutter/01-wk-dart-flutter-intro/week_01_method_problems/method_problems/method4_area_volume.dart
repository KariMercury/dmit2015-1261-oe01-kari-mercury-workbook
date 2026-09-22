// Method Problem 4 - Surface Area and Volume of a Rectangular Box
// Run with:  dart run method_problems/method4_area_volume.dart
//
// CalculateArea() and CalculateVolume() each receive length, width and
// height and return the surface area or volume respectively.

import 'dart:io';

/// Returns the surface area of a rectangular box: 2(lw + lh + wh).
int CalculateArea(int length, int width, int height) {
  return 2 * ((length * width) + (length * height) + (width * height));
}

/// Returns the volume of a rectangular box: l * w * h.
int CalculateVolume(int length, int width, int height) {
  return length * width * height;
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
  print('=== Rectangular Box Calculator ===');

  int length = readPositiveInt('Enter length: ');
  int width = readPositiveInt('Enter width:  ');
  int height = readPositiveInt('Enter height: ');

  int area = CalculateArea(length, width, height);
  int volume = CalculateVolume(length, width, height);

  print('');
  print('Dimensions:   $length x $width x $height');
  print('Surface area: $area square units');
  print('Volume:       $volume cubic units');
}
