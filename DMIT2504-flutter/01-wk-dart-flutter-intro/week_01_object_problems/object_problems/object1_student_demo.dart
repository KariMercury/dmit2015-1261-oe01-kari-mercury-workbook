// Object Problem 1 - Student class demo
// Run with:  dart run object_problems/object1_student_demo.dart
//
// Small program that exercises every member of the Student class
// defined in student.dart.

import 'student.dart';

void main() {
  print('=== Student Class Demo ===');

  // Default constructor, then use the setters.
  Student first = Student();
  first.SetFirstName('Jane');
  first.SetLastName('Doe');
  int storedId = first.SetIdNumber(1);

  print('Student 1');
  print('  First name: ${first.GetFirstName()}');
  print('  Last name:  ${first.GetLastName()}');
  print('  Id number:  ${first.GetIdNumber()} (SetIdNumber returned $storedId)');
  print('  Full name:  ${first.GetFullName()}');

  // Parameterized constructor.
  Student second = Student.withDetails('Sally', 'Anne', 2);

  print('Student 2');
  print('  First name: ${second.GetFirstName()}');
  print('  Last name:  ${second.GetLastName()}');
  print('  Id number:  ${second.GetIdNumber()}');
  print('  Full name:  ${second.GetFullName()}');
}
