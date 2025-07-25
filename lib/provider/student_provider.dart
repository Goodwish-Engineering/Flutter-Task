import 'package:flutter/material.dart';
import 'package:flutter_task/models/student_model.dart';

class StudentProvider with ChangeNotifier {
  Student? _student;

  // Public getter to access the student data
  Student? get student => _student;

  // Method to set the student data
  void setStudent(Student student) {
    _student = student;
    notifyListeners(); // Notify listeners about the change
  }

  // Method to clear the student data
  void clearStudent() {
    _student = null;
    notifyListeners(); // Notify listeners about the change
  }
}