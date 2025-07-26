import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:studentprofileapp/common/constant/constant_colors.dart';
import 'package:studentprofileapp/common/widgets/common_button.dart';
import 'package:studentprofileapp/common/widgets/divider.dart';
import 'package:studentprofileapp/features/student_details/bloc/studentdetails_bloc.dart';
import 'package:studentprofileapp/features/student_registration/bloc/student_registration_bloc.dart';
import 'package:studentprofileapp/features/student_registration/model/student_registration_model.dart';
import 'package:studentprofileapp/routes/app_routes.dart';

// profile picture

class StudentPicture extends StatelessWidget {
  const StudentPicture({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child:
          BlocSelector<
            StudentdetailsBloc,
            StudentdetailsState,
            StudentRegistrationModel
          >(
            selector: (state) => (state is Loaded)
                ? state.student
                : StudentRegistrationModel.empty(),
            builder: (context, student) {
              return Column(
                children: [
                  CircleAvatar(
                    foregroundImage: student.profileUrl.isEmpty
                        ? null
                        : FileImage(File(student.profileUrl)),
                    radius: 70.r,
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    student.name,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    student.email,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
    );
  }
}
// submit button

// Phone Number part
class PhoneNumber extends StatelessWidget {
  const PhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocSelector<StudentdetailsBloc, StudentdetailsState, String>(
      selector: (state) => (state is Loaded) ? state.student.number : '',
      builder: (context, phoneNumber) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 6.w),
          decoration: BoxDecoration(
            color: AppColors.greyContainerColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                "Contact Number : ",
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                phoneNumber.toString(),
                style: theme.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

// Dat eOf Birth part
class DateOfBirth extends StatelessWidget {
  const DateOfBirth({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocSelector<StudentdetailsBloc, StudentdetailsState, DateTime>(
      selector: (state) =>
          (state is Loaded) ? state.student.dob : DateTime.now(),
      builder: (context, dob) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 6.w),
          decoration: BoxDecoration(
            color: AppColors.greyContainerColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date of Birth : ",
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                dob.toString().split(' ').first,
                style: theme.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

// Gender part
class Gender extends StatelessWidget {
  const Gender({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocSelector<StudentdetailsBloc, StudentdetailsState, String>(
      selector: (state) => (state is Loaded) ? state.student.gender : '',
      builder: (context, gender) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 6.w),
          decoration: BoxDecoration(
            color: AppColors.greyContainerColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Gender : ",
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                gender,
                style: theme.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}

// Buttons

class EditAndDelete extends StatelessWidget {
  const EditAndDelete({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlocSelector<
          StudentdetailsBloc,
          StudentdetailsState,
          StudentRegistrationModel
        >(
          selector: (state) => (state is Loaded)
              ? state.student
              : StudentRegistrationModel.empty(),
          builder: (_, student) {
            return CommonButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.studentRegistration);
                context.read<StudentRegistrationBloc>().add(
                  EditProfile(student: student),
                );
              },
              buttonText: "Edit",
            );
          },
        ),
        CommonButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
              titlePadding: EdgeInsets.only(top: 10.h),
              title: Center(
                child: Text(
                  "Delete",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              backgroundColor: theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(8.r),
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10.h,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDivider(),
                  SizedBox(height: 10.h),
                  Text(
                    "Are you sure you want to delete it?",
                    style: theme.textTheme.bodyLarge!.copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                      CommonButton(
                        height: 50,
                        btnColor: AppColors.red,
                        onPressed: () async {
                          final getStorage = GetStorage();
                          getStorage.remove('student');
                          Navigator.pushNamed(
                            context,
                            AppRoutes.studentRegistration,
                          );
                        },
                        buttonText: "Yes",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          buttonText: "Delete",
          btnColor: AppColors.red,
        ),
      ],
    );
  }
}

// title
class StudentDetailsTitle extends StatelessWidget {
  const StudentDetailsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(child: Text("Student Details", style: textTheme.bodyLarge));
  }
}
