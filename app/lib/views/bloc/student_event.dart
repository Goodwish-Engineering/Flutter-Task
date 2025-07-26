part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

class StudentRegisterEvent extends StudentEvent {
  final Student student;

  StudentRegisterEvent({required this.student});
}

class StudentEditRegistrationEvent extends StudentEvent {
  final Student student;

  StudentEditRegistrationEvent({required this.student});
}
