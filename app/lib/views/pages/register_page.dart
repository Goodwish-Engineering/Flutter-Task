import 'dart:io';

import 'package:app/config/app_palette.dart';
import 'package:app/config/app_routes.dart';
import 'package:app/model/gender_type_enum.dart';
import 'package:app/model/student.dart';
import 'package:app/utils/format_date_time.dart';
import 'package:app/utils/show_snackbar.dart';
import 'package:app/views/bloc/student_bloc.dart';
import 'package:app/views/widgets/add_photo_widget.dart';
import 'package:app/views/widgets/auth_fields.dart';
import 'package:app/views/widgets/dob_picker.dart';
import 'package:app/views/widgets/gender_dropdown.dart';
import 'package:app/views/widgets/screen_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Move controllers to class level
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController dobController;
  late final GlobalKey<FormState> formKey;

  DateTime? selectedDate;
  Gender? selectedGender;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    // Initialize controllers once
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    dobController = TextEditingController();
    formKey = GlobalKey<FormState>();

    // Check if we're in edit mode and populate fields
    final currentState = context.read<StudentBloc>().state;
    if (currentState is StudentEditState) {
      _populateFields(currentState.student);
    }
  }

  void _populateFields(Student student) {
    nameController.text = student.fullName;
    emailController.text = student.email;
    phoneController.text = student.contactNumber;
    selectedDate = student.dob;
    selectedGender = student.gender;
    dobController.text = formatDateTime(true, student.dob.toIso8601String());
    selectedImage = student.profilePicture;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  // Updated method to handle date selection
  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      dobController.text = formatDateTime(true, date.toIso8601String());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWithBackground(
      child: BlocListener<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is StudentRegisterSuccessState) {
            showSnackbar(context, 'Student Registered Successfully!!!');
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header section with title
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Register Here',
                    style: TextStyle(
                      color: AppPallete.backgroundColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Awesome',
                      letterSpacing: 8,
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Expanded container with curved top edges
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AddPhotoWidget(
                              initialImage: selectedImage,
                              onImagePicked: (File? image) {
                                setState(() {
                                  selectedImage = image;
                                });
                                // Now you can use _selectedImage anywhere in your page
                                print('Image path: ${selectedImage?.path}');
                              },
                            ),
                            SizedBox(height: 20),

                            AuthField(
                              controller: nameController,
                              placeholder: 'Enter Name',
                            ),

                            SizedBox(height: 20),

                            AuthField(
                              controller: emailController,
                              placeholder: 'Enter Email',
                              isEmail: true,
                            ),

                            SizedBox(height: 20),

                            AuthField(
                              controller: phoneController,
                              placeholder: 'Enter Phone',
                              isNumber: true,
                            ),

                            SizedBox(height: 20),

                            // Date and Gender Row - updated with proper constraints
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth * 0.48,
                                      child: DobPickerField(
                                        controller: dobController,
                                        onDateSelected:
                                            _onDateSelected, // Use the updated method
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.48,
                                      child: GenderDropdownField(
                                        value: selectedGender,
                                        onChanged:
                                            (val) => setState(() {
                                              selectedGender = val;
                                            }),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),

                            SizedBox(height: 30),

                            // Register Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (selectedDate == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please select date of birth",
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    if (selectedGender == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Please select gender"),
                                        ),
                                      );
                                      return;
                                    }

                                    final student = Student(
                                      fullName: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      contactNumber:
                                          phoneController.text.trim(),
                                      dob:
                                          selectedDate!, // Use selectedDate (DateTime)
                                      gender: selectedGender!,
                                      profilePicture: selectedImage,
                                    );

                                    context.read<StudentBloc>().add(
                                      StudentRegisterEvent(student: student),
                                    );
                                  }
                                },
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    color: AppPallete.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
