import 'package:flutter/material.dart';
import 'package:student_profile/helper/student_model.dart';

class StudentProvider extends ChangeNotifier{
  StudentModel? _student;

  StudentModel? get student => _student;

  void setStudent(StudentModel student){
    _student = student;
    notifyListeners();
  }

  void clearStudent(){
    _student = null;
    notifyListeners();
  }
}