import 'package:flutter/material.dart';
import 'package:task/models/student.dart';

class StudentProvider extends ChangeNotifier {
  Student? _student;

  Student? get student => _student;

  void setStudent(Student student) {
    _student = student;
    notifyListeners();
  }

  void clearStuent() {
    _student = null;
    notifyListeners();
  }
}
