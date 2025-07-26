import 'package:flutter/material.dart';
import 'package:student_profile_app/models/student.dart';

class StudentProvider with ChangeNotifier {
  Student? _student;
  bool _isDarkTheme = false;
  Student? get student => _student;
  bool? get isDarkTheme => _isDarkTheme;
  void saveStudent(Student student) {
    _student = student;
    notifyListeners();
  }

  void updateStudent(Student student) {
    _student = student;
    notifyListeners();
  }

  void deleteStudent() {
    _student = null;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
