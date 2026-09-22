// Object Problem 1 - Student class
//
// This file only contains the Student class so it can be imported by
// other programs (see object1_student_demo.dart and object2_class_roster.dart).
//
// UML:
//   Student
//   - FirstName: String
//   - LastName: String
//   - IdNumber: Integer
//   + Student()
//   + Student(FirstName, LastName, IdNumber)
//   + GetFirstName(): String
//   + SetFirstName(FirstName): Void
//   + GetLastName(): String
//   + SetLastName(LastName): Void
//   + GetIdNumber(): Integer
//   + SetIdNumber(IdNumber): Integer
//   + GetFullName(): String

class Student {
  // Private fields (Dart uses a leading underscore for private members).
  //
  // Null safety: these are NON-nullable (String, not String?). Dart requires
  // every non-nullable field to have a value by the time the constructor
  // finishes, otherwise you get the compile error
  //   "Non-nullable instance field '_firstName' must be initialized."
  // That is why both constructors below use an initializer list (the part
  // after the colon) to give every field a value up front.
  String _firstName;
  String _lastName;
  int _idNumber;

  /// Default constructor - creates an empty student.
  /// We use '' and 0 rather than null so the fields can stay non-nullable
  /// and callers never have to null-check GetFirstName() etc.
  Student()
      : _firstName = '',
        _lastName = '',
        _idNumber = 0;

  /// Parameterized constructor.
  /// Dart does not allow two constructors with the same name, so this one
  /// is a named constructor: Student.withDetails('Jane', 'Doe', 1).
  Student.withDetails(String firstName, String lastName, int idNumber)
      : _firstName = firstName,
        _lastName = lastName,
        _idNumber = idNumber;

  String GetFirstName() {
    return _firstName;
  }

  void SetFirstName(String firstName) {
    _firstName = firstName;
  }

  String GetLastName() {
    return _lastName;
  }

  void SetLastName(String lastName) {
    _lastName = lastName;
  }

  int GetIdNumber() {
    return _idNumber;
  }

  /// Sets the id number and returns the value that was stored
  /// (the UML shows this method returning an Integer).
  int SetIdNumber(int idNumber) {
    _idNumber = idNumber;
    return _idNumber;
  }

  /// Returns the full name formatted as "LastName, FirstName".
  String GetFullName() {
    return '$_lastName, $_firstName';
  }
}
