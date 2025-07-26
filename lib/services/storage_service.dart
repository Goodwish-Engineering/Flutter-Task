import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student.dart';

class StorageService {
  static const String _studentKey = 'student_data_niranjan_dahal_app';
  static const String _themeKey = 'theme_mode';

  static Future<void> saveStudent(Student student) async {
    final prefs = await SharedPreferences.getInstance();
    final studentJson = json.encode(student.toJson());
    await prefs.setString(_studentKey, studentJson);
  }

  static Future<Student?> loadStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final studentJson = prefs.getString(_studentKey);
    if (studentJson != null) {
      final studentMap = json.decode(studentJson) as Map<String, dynamic>;
      return Student.fromJson(studentMap);
    }
    return null;
  }

  static Future<void> deleteStudent() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_studentKey);
  }

  static Future<void> saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, themeMode.toString());
  }

  static Future<ThemeMode> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeKey);
    if (themeModeString != null) {
      return ThemeMode.values.firstWhere(
        (mode) => mode.toString() == themeModeString,
        orElse: () => ThemeMode.system,
      );
    }
    return ThemeMode.system;
  }
}
