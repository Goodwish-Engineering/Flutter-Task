import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studentprofileapp/features/student_details/widget/loaded_student_details_widget.dart';

class LoadedStudentDetails extends StatelessWidget {
  const LoadedStudentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 50.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              const StudentDetailsTitle(),
              const StudentPicture(),
              SizedBox(height: 30.h),
              const PhoneNumber(),
              const DateOfBirth(),
              const Gender(),
              SizedBox(height: 40.h),
              const EditAndDelete(),
            ],
          ),
        ),
      ),
    );
  }
}
