import 'dart:convert';
import 'dart:io';

class StudentModel {
  String fullName;
  String email;
  String contact;
  DateTime dob;
  String gender;
  File? profileImage;

  StudentModel({
    required this.fullName,
    required this.email,
    required this.contact,
    required this.dob,
    required this.gender,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'contact': contact,
      'dob': dob.toIso8601String(),
      'gender': gender,
      'profileImage': profileImage?.path,
    };
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      fullName: json['fullName'],
      email: json['email'],
      contact: json['contact'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      profileImage: json['profileImage'] != null ? File(json['profileImage']) : null,
    );
  }
}
