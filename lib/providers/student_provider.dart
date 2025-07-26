import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/storage_service.dart';

class StudentProvider with ChangeNotifier {
  Student? _student;
  bool _isLoading = false;

  Student? get student => _student;
  bool get isLoading => _isLoading;
  bool get hasStudent => _student != null;

  StudentProvider() {
    _loadStudent();
  }

  Future<void> _loadStudent() async {
    _isLoading = true;
    notifyListeners();
    
    _student = await StorageService.loadStudent();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveStudent(Student student) async {
    _isLoading = true;
    notifyListeners();

    _student = student;
    await StorageService.saveStudent(student);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteStudent() async {
    _isLoading = true;
    notifyListeners();

    _student = null;
    await StorageService.deleteStudent();

    _isLoading = false;
    notifyListeners();
  }

  void updateStudent(Student student) {
    _student = student;
    notifyListeners();
  }
}
