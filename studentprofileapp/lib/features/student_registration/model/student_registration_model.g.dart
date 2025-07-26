// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudentRegistrationModel _$StudentRegistrationModelFromJson(
  Map<String, dynamic> json,
) => _StudentRegistrationModel(
  name: json['name'] as String,
  profileUrl: json['profileUrl'] as String,
  email: json['email'] as String,
  number: json['number'] as String,
  gender: json['gender'] as String,
  dob: DateTime.parse(json['dob'] as String),
);

Map<String, dynamic> _$StudentRegistrationModelToJson(
  _StudentRegistrationModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'profileUrl': instance.profileUrl,
  'email': instance.email,
  'number': instance.number,
  'gender': instance.gender,
  'dob': instance.dob.toIso8601String(),
};
