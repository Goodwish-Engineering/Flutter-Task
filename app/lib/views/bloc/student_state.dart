part of 'student_bloc.dart';

@immutable
sealed class StudentState {}

final class StudentInitial extends StudentState {}

final class StudentRegisterSuccessState extends StudentState {
  final Student student;

  StudentRegisterSuccessState({required this.student});
}
