import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:studentprofileapp/features/student_registration/model/student_registration_model.dart';
part 'studentdetails_event.dart';
part 'studentdetails_state.dart';
part 'studentdetails_bloc.freezed.dart';

class StudentdetailsBloc
    extends Bloc<StudentdetailsEvent, StudentdetailsState> {
  final GetStorage _getStorage = GetStorage();
  StudentdetailsBloc() : super(_Initial()) {
    on<GetStudentData>(_onGetStudentData);
  }

  FutureOr<void> _onGetStudentData(event, emit) {
try {
      emit(StudentdetailsState.loading());
    final data =
        _getStorage.read('student') ?? StudentRegistrationModel.empty();
    if (data != null) {
      final student = StudentRegistrationModel.fromJson(
        Map<String, dynamic>.from(data),
      );
      emit(StudentdetailsState.loaded(student: student));
    } 
} catch (e) {
  emit(StudentdetailsState.error(errorMessage: e.toString()));
}
  }
}
