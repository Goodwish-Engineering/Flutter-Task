import 'dart:convert';
import 'package:flutter/material.dart';
import '../Models/Student_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StudentProvider extends ChangeNotifier {
  StudentModel? _student;
  StudentModel? get student => _student;

  Future<void> setStudent(StudentModel model) async {
    _student = model;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('student_data', jsonEncode(model.toJson()));
  }

  Future<void> loadStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('student_data');
    if (data != null) {
      _student = StudentModel.fromJson(jsonDecode(data));
      notifyListeners();
    }
  }

  Future<void> clear() async {
    _student = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('student_data');
  }
}
