import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String? fullName;
  final String? email;
  final String? contactNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? profilePicturePath;

  const Student({
    this.fullName,
    this.email,
    this.contactNumber,
    this.dateOfBirth,
    this.gender,
    this.profilePicturePath,
  });

  Student copyWith({
    String? fullName,
    String? email,
    String? contactNumber,
    String? dateOfBirth,
    String? gender,
    String? profilePicturePath,
  }) {
    return Student(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      profilePicturePath: profilePicturePath ?? this.profilePicturePath,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    email,
    contactNumber,
    dateOfBirth,
    gender,
    profilePicturePath,
  ];
}
