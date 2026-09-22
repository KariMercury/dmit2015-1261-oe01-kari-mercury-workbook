class Person {
  late String _name;
  late int _age;

  Person(String name, int age) {
    this.name = name;
    this.age = age;
  }

  /// The name of the person
  String get name {
    return _name;
  }

  set name(String value) {
    if (value.trim().isEmpty) {
      throw Exception('Name cannot be empty');
    }

    _name = value;
  }

  /// The age for the person
  int get age {
    return _age;
  }

  set age(int value) {
    if (value < 0) {
      throw Exception('Age must be greater than or equal to zero');
    }

    _age = value;
  }
}
