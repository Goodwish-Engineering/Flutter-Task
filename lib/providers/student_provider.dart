import 'package:flutter/material.dart';
import '../models/student_model.dart';

class StudentProvider with ChangeNotifier {
  Student _student = Student();

  Student get student => _student;

  void updateStudent(Student newStudent) {
    _student = newStudent;
    notifyListeners();
  }

  void clearStudent() {
    _student = Student();
    notifyListeners();
  }
}
