// Method Problem 3 - Gross Pay Calculator
// Run with:  dart run method_problems/method3_calculate_pay.dart
//
// CalculatePay() receives hours worked and an hourly pay rate and returns
// gross pay:
//   - hours 1 to 40          -> regular pay
//   - hours over 40 up to 50 -> time and a half (1.5x)
//   - hours over 50          -> double time (2x)

import 'dart:io';

/// Returns gross pay for the given hours and hourly rate.
double CalculatePay(int hours, int payRate) {
  const int regularLimit = 40;
  const int overtimeLimit = 50;
  const double timeAndHalf = 1.5;
  const double doubleTime = 2.0;

  double grossPay = 0;

  if (hours <= regularLimit) {
    // All hours are regular time.
    grossPay = hours * payRate.toDouble();
  } else if (hours <= overtimeLimit) {
    // First 40 hours regular, hours 41-50 at time and a half.
    int overtimeHours = hours - regularLimit;
    grossPay = (regularLimit * payRate) + (overtimeHours * payRate * timeAndHalf);
  } else {
    // First 40 regular, next 10 at time and a half, the rest at double time.
    int timeAndHalfHours = overtimeLimit - regularLimit;
    int doubleTimeHours = hours - overtimeLimit;
    grossPay = (regularLimit * payRate) +
        (timeAndHalfHours * payRate * timeAndHalf) +
        (doubleTimeHours * payRate * doubleTime);
  }

  return grossPay;
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
  print('=== Gross Pay Calculator ===');

  int hours = readPositiveInt('Enter hours worked:      ');
  int payRate = readPositiveInt('Enter hourly pay rate (\$): ');

  double grossPay = CalculatePay(hours, payRate);

  print('');
  print('Hours worked: $hours');
  print('Pay rate:     \$$payRate/hour');
  print('Gross pay:    \$${grossPay.toStringAsFixed(2)}');
}
