// Object Problem 2 - Class Roster
// Run with:  dart run object_problems/object2_class_roster.dart
//
// Menu-driven program that stores up to 25 Student objects in an array
// and prints a formatted roster.

import 'dart:io';
import 'student.dart';

const int maxStudents = 25;

/// Reads a line of text, repeating until something non-blank is entered.
///
/// Null safety: readLineSync() returns String?, so we cannot call .trim()
/// on it directly - the compiler would report "The method 'trim' can't be
/// unconditionally invoked because the receiver can be 'null'". A null line
/// means input has ended (Ctrl+Z), so we exit; after that check Dart
/// promotes `line` to a plain String and .trim() is allowed.
String readNonEmptyString(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? line = stdin.readLineSync();

    if (line == null) {
      print('\nNo more input - exiting.');
      exit(1);
    }

    String input = line.trim();
    if (input.isEmpty) {
      print('  A value is required. Please try again.');
    } else {
      return input;
    }
  }
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

/// Prompts for one student's details and stores it in the next open slot.
void enterStudent(List<Student?> roster, int count) {
  print('');
  print('--- Enter Student ${count + 1} of $maxStudents ---');

  int id = readPositiveInt('Id number:  ');
  String lastName = readNonEmptyString('Last name:  ');
  String firstName = readNonEmptyString('First name: ');

  roster[count] = Student.withDetails(firstName, lastName, id);
  print('Student added.');
}

/// Prints the roster in the required column format.
void viewReport(List<Student?> roster, int count) {
  print('');
  print('${'Id'.padRight(4)}${'Last Name'.padRight(15)}${'First Name'.padRight(15)}');
  print('${'--'.padRight(4)}${'---------'.padRight(15)}${'----------'.padRight(15)}');

  for (int i = 0; i < count; i++) {
    // roster[i] has type Student? because the list allows empty slots.
    // The `!` (null assertion / "bang") operator tells Dart "I promise this
    // is not null - treat it as a Student". It is safe here ONLY because the
    // loop stops at `count`, and every slot below `count` has been filled.
    // If the promise were wrong, the program would crash at runtime with a
    // "Null check operator used on a null value" error, so use `!` sparingly.
    Student student = roster[i]!;
    print('${student.GetIdNumber().toString().padRight(4)}'
        '${student.GetLastName().padRight(15)}'
        '${student.GetFirstName().padRight(15)}');
  }

  print('');
  print('Total Students: $count');
}

void main() {
  // Array of Student with room for 25. Slots start out empty (null).
  //
  // Null safety: the element type is Student? (nullable), not Student.
  // A fixed-length List<Student>.filled(25, ...) would need a real Student
  // to copy into every slot, and we do not have 25 students yet. Making the
  // element type nullable lets us use null to mean "this seat is empty".
  // `count` tracks how many slots are actually filled.
  List<Student?> roster = List<Student?>.filled(maxStudents, null);
  int count = 0;

  bool running = true;
  while (running) {
    print('');
    print('=== Class Roster Menu ===');
    print('1. Enter a student');
    print('2. View report');
    print('3. Quit');
    stdout.write('Choose an option (1-3): ');

    // Null safety: `??` (if-null operator) - use the line that was read, but
    // if readLineSync() returned null (input ended) use '3' so the menu quits
    // instead of looping forever on "Invalid option".
    String choice = (stdin.readLineSync() ?? '3').trim();

    switch (choice) {
      case '1':
        if (count >= maxStudents) {
          print('The roster is full ($maxStudents students).');
        } else {
          enterStudent(roster, count);
          count++;
        }
        break;
      case '2':
        viewReport(roster, count);
        break;
      case '3':
        running = false;
        print('Goodbye.');
        break;
      default:
        print('Invalid option. Please enter 1, 2 or 3.');
    }
  }
}
