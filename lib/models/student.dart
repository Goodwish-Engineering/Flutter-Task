import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String contactNumber;

  @HiveField(3)
  final String dateOfBirth;

  @HiveField(4)
  final String profilePath;

  @HiveField(5)
  final String gender;

  Student({
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.dateOfBirth,
    required this.profilePath,
    required this.gender,
  });
}
