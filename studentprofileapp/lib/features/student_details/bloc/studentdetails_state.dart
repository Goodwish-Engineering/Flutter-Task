part of 'studentdetails_bloc.dart';

@freezed
class StudentdetailsState with _$StudentdetailsState {
  const factory StudentdetailsState.initial() = _Initial;
  const factory StudentdetailsState.loading() = Loading;
  const factory StudentdetailsState.loaded({
    required StudentRegistrationModel student,
  }) = Loaded;
  const factory StudentdetailsState.error({required String errorMessage}) =
      Error;
}
