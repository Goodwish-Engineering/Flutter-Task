import 'package:app/model/student.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<StudentEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<StudentRegisterEvent>((event, emit) {
      emit(StudentRegisterSuccessState(student: event.student));
    });

    on<StudentEditRegistrationEvent>((event, emit) {
      emit(StudentEditState(student: event.student));
    });
  }
}
