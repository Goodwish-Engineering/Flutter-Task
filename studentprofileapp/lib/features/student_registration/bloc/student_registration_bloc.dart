import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentprofileapp/features/student_registration/model/student_registration_model.dart';
import 'package:studentprofileapp/features/student_registration/repository/student_registration_repository.dart';
part 'student_registration_event.dart';
part 'student_registration_state.dart';
part 'student_registration_bloc.freezed.dart';

class StudentRegistrationBloc
    extends Bloc<StudentRegistrationEvent, StudentRegistrationState> {
  final GetStorage _getStorage = GetStorage();
  StudentRegistrationModel _model = StudentRegistrationModel.empty();
  final StudentRegistrationRepository _registrationRepository =
      StudentRegistrationRepository();
  StudentRegistrationBloc() : super(_Initial()) {
    on<Profile>(_onProfile);
    on<Name>(_onName);
    on<Email>(_onEmail);
    on<Phone>(_onPhone);
    on<Dob>(_onDob);
    on<Gender>(_onGender);
    on<Submit>(_onSubmit);
    on<EditProfile>(_onEditProfile);
  }

  Future<void> _onProfile(
    Profile event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    final path = await _registrationRepository.imagePicker(event.source);
    if (path != null) {
      emit(StudentRegistrationState.profileUploaded(url: path));
      _model = _model.copyWith(profileUrl: path);
    }
  }

  _onName(Name event, Emitter<StudentRegistrationState> emit) {
    _model = _model.copyWith(name: event.name);
  }

  _onEmail(Email event, Emitter<StudentRegistrationState> emit) {
    _model = _model.copyWith(email: event.email);
  }

  _onPhone(Phone event, Emitter<StudentRegistrationState> emit) {
    _model = _model.copyWith(number: event.phone);
  }

  _onDob(Dob event, Emitter<StudentRegistrationState> emit) {
    

    _model = _model.copyWith(dob: event.dob);
  }

  _onGender(Gender event, Emitter<StudentRegistrationState> emit) {

    _model = _model.copyWith(gender: event.gender);
  }

  FutureOr<void> _onSubmit(
    Submit event,
    Emitter<StudentRegistrationState> emit,
  ) {
    _getStorage.write('student', _model.toJson());
    emit(StudentRegistrationState.success(message: event.message));
  }

  FutureOr<void> _onEditProfile(
    EditProfile event,
    Emitter<StudentRegistrationState> emit,
  ) {
    emit(StudentRegistrationState.editProfileState(student: event.student));
  }
}
