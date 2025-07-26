part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

class StudentRegisterEvent extends StudentEvent {
  final Student student;

  StudentRegisterEvent({required this.student});
}
