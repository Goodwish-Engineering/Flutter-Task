import 'dart:io';

class Student {
  String? name;
  String? email;
  String? contact;
  String? dob;
  String? gender;
  File? profileImage;

  Student({
    this.name,
    this.email,
    this.contact,
    this.dob,
    this.gender,
    this.profileImage,
  });

  void clear() {
    name = null;
    email = null;
    contact = null;
    dob = null;
    gender = null;
    profileImage = null;
  }
}
