import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends Equatable {
  @HiveField(0)
  final String? fullName;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? contactNumber;
  @HiveField(3)
  final String? dateOfBirth;
  @HiveField(4)
  final String? gender;
  @HiveField(5)
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
