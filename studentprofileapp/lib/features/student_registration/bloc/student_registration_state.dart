part of 'student_registration_bloc.dart';

@freezed
class StudentRegistrationState with _$StudentRegistrationState {
  const factory StudentRegistrationState.initial() = _Initial;
  const factory StudentRegistrationState.profileUploaded({
    required String url,
    
  }) = ProfileUploaded;
  const factory StudentRegistrationState.success({ required String message}) = Success;
  const factory StudentRegistrationState.error({required String errorMessage}) =
      Error;

  const factory StudentRegistrationState.editProfileState({
    required StudentRegistrationModel student,
  }) = EditProfileState;
}
