import 'dart:io';

class Student {
  String fullName;
  String email;
  String contactNumber;
  DateTime dob;
  Gender gender;
  File profilePicture;

  Student({
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.dob,
    required this.gender,
    required this.profilePicture,
  });
}

enum Gender { male, female, other }