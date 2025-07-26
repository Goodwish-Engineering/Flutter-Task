import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_registration_model.freezed.dart';
part 'student_registration_model.g.dart';

@freezed
abstract class StudentRegistrationModel with _$StudentRegistrationModel {
  const factory StudentRegistrationModel({
    required String name,
    required String profileUrl,
    required String email,
    required String number,
    required String gender,
    required DateTime dob,
  }) = _StudentRegistrationModel;

  factory StudentRegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$StudentRegistrationModelFromJson(json);

  factory StudentRegistrationModel.empty() => StudentRegistrationModel(
    name: '',
    profileUrl: '',
    email: '',
    number: '',
    gender: '',
    dob: DateTime.now(),
  );
}
