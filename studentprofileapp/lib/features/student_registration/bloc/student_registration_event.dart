part of 'student_registration_bloc.dart';

@freezed
abstract class StudentRegistrationEvent with _$StudentRegistrationEvent {
  const factory StudentRegistrationEvent.name({required String name}) = Name;
  const factory StudentRegistrationEvent.email({required String email}) = Email;
  const factory StudentRegistrationEvent.phone({required String phone}) = Phone;
  const factory StudentRegistrationEvent.dob({required DateTime dob}) = Dob;
  const factory StudentRegistrationEvent.gender({required String gender}) =
      Gender;
  const factory StudentRegistrationEvent.profile({
    required ImageSource source
  }) = Profile;
  const factory StudentRegistrationEvent.editProfile({
    required StudentRegistrationModel student,
  }) = EditProfile;
  const factory StudentRegistrationEvent.submit({ required String message}) = Submit;
}
