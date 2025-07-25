import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task/models/student.dart';

class StudentProvider with ChangeNotifier {
  Box<Student> studentBox = Hive.box<Student>('studentbox');

  Student? get student {
    if (studentBox.isNotEmpty) {
      return studentBox.getAt(0);
    }
    return null;
  }

  void setStudent(Student student) {
    if (studentBox.isEmpty) {
      studentBox.add(student);
    } else {
      studentBox.putAt(0, student);
    }
    notifyListeners();
  }

  void clearStudent() {
    studentBox.clear();
    notifyListeners();
  }
}
