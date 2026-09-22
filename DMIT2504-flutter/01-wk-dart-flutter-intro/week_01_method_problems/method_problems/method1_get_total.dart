// Method Problem 1 - Pocket Change Tally
// Run with:  dart run method_problems/method1_get_total.dart
//
// GetTotal() receives the number of pennies, nickels, dimes, quarters,
// loonies and twoonies and returns the total amount in dollars.

import 'dart:io';

/// Returns the total dollar value of all the coins passed in.
double GetTotal(int pennies, int nickels, int dimes, int quarters,
    int loonies, int twoonies) {
  double total = 0;
  total += pennies * 0.01;
  total += nickels * 0.05;
  total += dimes * 0.10;
  total += quarters * 0.25;
  total += loonies * 1.00;
  total += twoonies * 2.00;
  return total;
}

/// Keeps prompting until the user enters a whole number of at least [min].
///
/// `prompt` is a required positional parameter.
/// `min` is a NAMED parameter with a DEFAULT value, so callers can write
/// either readPositiveInt('Age: ') or readPositiveInt('Age: ', min: 1).
///
/// NULL SAFETY NOTES
/// * readLineSync() returns String? (nullable) because input can END - the
///   user presses Ctrl+Z (Windows) or Ctrl+D (Mac/Linux). We cannot pass it
///   to int.tryParse() until we deal with the null case.
/// * We handle null by exiting. If we instead did `int.tryParse(input ?? '')`
///   the program would loop forever after Ctrl+Z, because '' never parses.
///   After the `if (input == null) exit` line, Dart PROMOTES input from
///   String? to String, so int.tryParse(input) compiles.
/// * int.tryParse() returns int? - null when the text is not a whole number.
///   Once we check `value == null`, Dart knows value is an int in the
///   remaining branches, so `value < 0` and `return value` compile without
///   any extra casting.
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
  print('=== Pocket Change Tally ===');

  int pennies = readPositiveInt('Number of pennies:  ');
  int nickels = readPositiveInt('Number of nickels:  ');
  int dimes = readPositiveInt('Number of dimes:    ');
  int quarters = readPositiveInt('Number of quarters: ');
  int loonies = readPositiveInt('Number of loonies:  ');
  int twoonies = readPositiveInt('Number of twoonies: ');

  double total = GetTotal(pennies, nickels, dimes, quarters, loonies, twoonies);

  print('');
  print('Total change: \$${total.toStringAsFixed(2)}');
}
