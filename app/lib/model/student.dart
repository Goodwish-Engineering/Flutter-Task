import 'dart:io';

import 'package:app/model/gender_type_enum.dart';

class Student {
  final String fullName;
  final String email;
  final String contactNumber;
  final DateTime dob;
  final Gender gender;
  final File? profilePicture;

  Student({
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.dob,
    required this.gender,
    required this.profilePicture,
  });
}
