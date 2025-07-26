import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studentprofileapp/common/widgets/snackbar_message.dart';
import 'package:studentprofileapp/features/student_registration/bloc/student_registration_bloc.dart';
import 'package:studentprofileapp/features/student_registration/widget/student_registration_screen_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentprofileapp/routes/app_routes.dart';

// student registration screen
class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<StudentRegistrationBloc, StudentRegistrationState>(
          listenWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType,
          listener: _listener,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 50.h),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20.h,
                  children: [
                    const StudentRegistrationText(),
                    const StudentProfilePicture(),
                    SizedBox(height: 15.h),
                    const StudentName(),
                    const StudentNameTextField(),
                    const StudentEmail(),
                    const StudentEmailTextField(),
                    const StudentContactNumber(),
                    const StudentContactNumberTextField(),
                    const StudentDOB(),
                    const StudentGender(),
                    SizedBox(height: 15.h),
                    SubmitButton(formKey: _formKey),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _listener(context, state) {
    if (state is Success) {
      snackBarMessage(context, state.message, Theme.of(context));
      Navigator.pushNamed(context, AppRoutes.studentDetails);
    }
  }
}
