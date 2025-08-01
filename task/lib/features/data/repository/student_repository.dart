import 'package:hive/hive.dart';

import 'package:task/core/models/hive/student.dart';

class StudentRepository {
  static const _boxName = 'studentBox';
  static const _studentKey = 'student';

  Future<void> saveStudent(Student student) async {
    final box = await Hive.openBox<Student>(_boxName);
    await box.put(_studentKey, student);
  }

  Future<Student?> loadStudent() async {
    final box = await Hive.openBox<Student>(_boxName);
    return box.get(_studentKey);
  }

  Future<void> deleteStudent() async {
    final box = await Hive.openBox<Student>(_boxName);
    await box.delete(_studentKey);
  }
}
