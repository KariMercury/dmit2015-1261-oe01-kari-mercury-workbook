import 'dart:io';

/// Returns an [int]
///
/// Will continue to prompt the user until a valid [int] is entered.
/// Displayst the [message] as the prompt for the user.
int promptInt(String message) {
  while (true) {
    try {
      return int.parse(prompt(message));
    } catch (e) {
      stdout.writeln('Invalid input. Please enter a whole number.');
    }
  }
}

/// Returns a [String]
///
/// Displays the passed in [message] as the prompt
/// for the user.
String prompt(String message) {
  stdout.write(message);
  return stdin.readLineSync()!;
}
