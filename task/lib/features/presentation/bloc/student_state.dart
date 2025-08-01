part of 'student_bloc.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentLoaded extends StudentState {
  final Student student;

  const StudentLoaded(this.student);

  @override
  List<Object> get props => [student];
}

class StudentEmpty extends StudentState {
  final String message;

  const StudentEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class StudentSaveSuccess extends StudentState {
  final String message;

  const StudentSaveSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class StudentDeleteSuccess extends StudentState {
  final String message;

  const StudentDeleteSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class StudentError extends StudentState {
  final String message;
  final String? details;
  final VoidCallback? retryAction;

  const StudentError(this.message, {this.details, this.retryAction});

  @override
  List<Object> get props => [message];
}
