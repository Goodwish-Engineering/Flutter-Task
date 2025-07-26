import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentprofileapp/common/constant/constant_colors.dart';
import 'package:studentprofileapp/features/student_details/bloc/studentdetails_bloc.dart';
import 'package:studentprofileapp/features/student_details/screen/loaded_student_details.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({super.key});

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudentdetailsBloc>().add(GetStudentData());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocBuilder<StudentdetailsBloc, StudentdetailsState>(
        buildWhen: (previous, current) =>
            previous.runtimeType != current.runtimeType,

        builder: (context, state) {
          return switch (state) {
            const Loading() => const CircularProgressIndicator(
              color: AppColors.blue,
            ),
            Error(:final errorMessage) => Center(
              child: Text(errorMessage, style: textTheme.bodyMedium),
            ),
            Loaded() => LoadedStudentDetails(),
            _ => SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
