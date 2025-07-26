 part of 'student_bloc.dart';

abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class LoadStudent extends StudentEvent {}

class SaveStudent extends StudentEvent {
  final Student student;

  const SaveStudent(this.student);

  @override
  List<Object> get props => [student];
}

class DeleteStudent extends StudentEvent {}