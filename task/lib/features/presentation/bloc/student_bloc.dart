import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/models/hive/student.dart';
import 'package:task/features/data/repository/student_repository.dart';
 
part 'student_event.dart';
part 'student_state.dart';

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);

  @override
  String toString() => message;
}

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository studentRepository;

  StudentBloc({required this.studentRepository}) : super(StudentInitial()) {
    on<LoadStudent>(_onLoadStudent);
    on<SaveStudent>(_onSaveStudent);
    on<DeleteStudent>(_onDeleteStudent);
  }

  void _onLoadStudent(LoadStudent event, Emitter<StudentState> emit) async {
    emit(StudentLoading());
    try {
      final student = await studentRepository.loadStudent();
      if (student == null) {
        emit(StudentEmpty('No student profile found'));
      } else {
        if (_isStudentEmpty(student)) {
          emit(StudentEmpty('No student profile found'));
        } else {
          emit(StudentLoaded(student));
        }
      }
    } catch (e) {
      emit(
        StudentError(
          'Failed to load profile data',
          details: 'Error: ${e.toString()}',
          retryAction: () => add(LoadStudent()),
        ),
      );
    }
  }

  bool _isStudentEmpty(Student student) {
    return (student.fullName == null || student.fullName!.isEmpty) &&
        (student.email == null || student.email!.isEmpty) &&
        (student.contactNumber == null || student.contactNumber!.isEmpty) &&
        (student.dateOfBirth == null || student.dateOfBirth!.isEmpty) &&
        (student.gender == null || student.gender!.isEmpty);
  }

  void _onSaveStudent(SaveStudent event, Emitter<StudentState> emit) async {
    emit(StudentLoading());
    try {
      if (event.student.fullName?.isEmpty ?? true) {
        throw ValidationException('Full name is required');
      }
      if (event.student.email?.isEmpty ?? true) {
        throw ValidationException('Email is required');
      }
      if (!RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(event.student.email ?? '')) {
        throw ValidationException('Invalid email format');
      }
      if (event.student.contactNumber?.isEmpty ?? true) {
        throw ValidationException('Contact number is required');
      }
      if (!RegExp(r'^\d{10}$').hasMatch(event.student.contactNumber ?? '')) {
        throw ValidationException('Contact number must be 10 digits');
      }
      if (event.student.dateOfBirth?.isEmpty ?? true) {
        throw ValidationException('Date of birth is required');
      }
      if (event.student.gender?.isEmpty ?? true) {
        throw ValidationException('Gender is required');
      }
      if (event.student.profilePicturePath?.isEmpty ?? true) {
        throw ValidationException('Profile picture is required');
      }

      await studentRepository.saveStudent(event.student);
      emit(StudentLoaded(event.student));
      emit(StudentSaveSuccess('Profile saved successfully'));
    } catch (e) {
      if (e is ValidationException) {
        emit(
          StudentError(
            e.message,
            details: 'Validation Error',
            retryAction: () => add(SaveStudent(event.student)),
          ),
        );
      } else {
        emit(
          StudentError(
            'Failed to save student data',
            details: 'Error: ${e.toString()}',
            retryAction: () => add(SaveStudent(event.student)),
          ),
        );
      }
    }
  }

  void _onDeleteStudent(DeleteStudent event, Emitter<StudentState> emit) async {
    emit(StudentLoading());
    try {
      await studentRepository.deleteStudent();

      emit(StudentDeleteSuccess('Profile deleted successfully'));

      emit(StudentEmpty('No student profile found'));
    } catch (e) {
      emit(
        StudentError(
          'Failed to delete student data',
          details: 'Error: ${e.toString()}',
          retryAction: () => add(DeleteStudent()),
        ),
      );
    }
  }
}
