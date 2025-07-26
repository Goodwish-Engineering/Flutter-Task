import 'dart:io';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentprofileapp/common/constant/constant_colors.dart';
import 'package:studentprofileapp/common/utils/validators.dart';
import 'package:studentprofileapp/common/widgets/common_button.dart';
import 'package:studentprofileapp/common/widgets/common_textfield.dart';
import 'package:studentprofileapp/common/widgets/divider.dart';
import 'package:studentprofileapp/common/widgets/snackbar_message.dart';
import 'package:studentprofileapp/features/student_registration/bloc/student_registration_bloc.dart';

// profile picture

class StudentProfilePicture extends StatelessWidget {
  const StudentProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10.h,
        children: [
          GestureDetector(
            onTap: () => showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => Padding(
                padding: EdgeInsets.all(14.r),
                child: Material(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(18.r),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          context.read<StudentRegistrationBloc>().add(
                            Profile(source: ImageSource.camera),
                          );
                          Navigator.pop(context);
                        },
                        leading: Icon(
                          CupertinoIcons.photo_camera,
                          color: theme.iconTheme.color,
                        ),
                        title: Text(
                          "Take a Picture",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      CustomDivider(),
                      ListTile(
                        onTap: () {
                          context.read<StudentRegistrationBloc>().add(
                            Profile(source: ImageSource.gallery),
                          );
                          Navigator.pop(context);
                        },
                        leading: Icon(
                          Icons.collections_outlined,
                          color: theme.iconTheme.color,
                        ),
                        title: Text(
                          "Select From Gallery",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            child:
                BlocSelector<
                  StudentRegistrationBloc,
                  StudentRegistrationState,
                  String
                >(
                  selector: (state) {
                    if (state is ProfileUploaded) {
                      return state.url;
                    }

                    if (state is EditProfileState) {
                      return state.student.profileUrl;
                    }
                    return '';
                  },
                  builder: (context, url) {
                    return CircleAvatar(
                      foregroundImage: url.isEmpty
                          ? null
                          : FileImage(File(url)),
                      radius: 60.r,
                    );
                  },
                ),
          ),
          Text("Upload Profile Picture", style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
// submit button

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
      builder: (context, state) {
        String url = '';
        bool isEdit = false;

        if (state is ProfileUploaded) {
          url = state.url;
        } else if (state is EditProfileState) {
          url = state.student.profileUrl;
          isEdit = true;
        }

        return CommonButton(
          onPressed: () {
            if (formKey.currentState!.validate() && url.isNotEmpty) {
              context.read<StudentRegistrationBloc>().add(
                Submit(
                  message: isEdit
                      ? "Profile updated successfully."
                      : "Welcome! Your registration is complete.",
                ),
              );
            } else {
              snackBarMessage(context, "Add a profile picture.", theme);
            }
          },
          buttonText: isEdit ? "Confirm" : "Submit",
        );
      },
    );
  }
}

// Gender part
class StudentGender extends StatefulWidget {
  const StudentGender({super.key});

  @override
  State<StudentGender> createState() => _StudentGenderState();
}

class _StudentGenderState extends State<StudentGender> {
  final List<DropdownMenuItem<String>> items = const [
    DropdownMenuItem(
      value: "Male",
      child: Center(child: Text("Male")),
    ),
    DropdownMenuItem(
      value: "Female",
      child: Center(child: Text("Female")),
    ),
    DropdownMenuItem(
      value: "Other",
      child: Center(child: Text("Other")),
    ),
  ];

  String selectedItem = "Male";
  bool _isGenderInitialized = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Select Your Gender", style: theme.textTheme.bodyMedium),
        Container(
          height: 50.h,
          width: 130.w,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: theme.cardColor, width: 1.w),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
            builder: (context, state) {
              if (state is EditProfileState && !_isGenderInitialized) {
                Future.microtask(() {
                  if (mounted) {
                    setState(() {
                      selectedItem = state.student.gender;
                      _isGenderInitialized = true;
                    });
                  }
                });
              }

              return Center(
                child: DropdownButton<String>(
                  dropdownColor: theme.scaffoldBackgroundColor,
                  style: theme.textTheme.bodyMedium,
                  underline: const SizedBox.shrink(),
                  value: selectedItem,
                  items: items,
                  onChanged: (value) {
                    setState(() {
                      selectedItem = value!;
                    });
                    context.read<StudentRegistrationBloc>().add(
                      Gender(gender: value!),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Date of birth part

class StudentDOB extends StatefulWidget {
  const StudentDOB({super.key});

  @override
  State<StudentDOB> createState() => _StudentDOBState();
}

class _StudentDOBState extends State<StudentDOB> {
  DateTime dobPickedValue = DateTime.now();
  bool _isDobInitialized = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Select Date of Birth", style: theme.textTheme.bodyMedium),
        InkWell(
          onTap: () => BottomPicker.date(
            height: 350.h,
            buttonStyle: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(8.r),
            ),
            pickerTitle: Text(
              "Select Date of Birth",
              style: theme.textTheme.bodyMedium!.copyWith(
                color: AppColors.blue,
              ),
            ),
            dateOrder: DatePickerDateOrder.ymd,
            initialDateTime: dobPickedValue,
            minDateTime: DateTime(1950),
            pickerTextStyle: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            onSubmit: (value) {
              setState(() {
                dobPickedValue = value;
              });
              context.read<StudentRegistrationBloc>().add(Dob(dob: value));
            },
            onChange: (_) {},
          ).show(context),
          child: Container(
            height: 50.h,
            width: 130.w,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: theme.cardColor, width: 1.w),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child:
                BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
                  builder: (context, state) {
                    if (state is EditProfileState && !_isDobInitialized) {
                      Future.microtask(() {
                        if (mounted) {
                          setState(() {
                            dobPickedValue = state.student.dob;
                            _isDobInitialized = true;
                          });
                        }
                      });
                    }

                    return Center(
                      child: Text(
                        dobPickedValue.toString().split(' ').first,
                        style: theme.textTheme.bodyMedium,
                      ),
                    );
                  },
                ),
          ),
        ),
      ],
    );
  }
}

// Contact Number part
class StudentContactNumber extends StatelessWidget {
  const StudentContactNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text("Contact Number", style: textTheme.bodyMedium);
  }
}

class StudentContactNumberTextField extends StatefulWidget {
  const StudentContactNumberTextField({super.key});

  @override
  State<StudentContactNumberTextField> createState() =>
      _StudentContactNumberTextFieldState();
}

class _StudentContactNumberTextFieldState
    extends State<StudentContactNumberTextField> {
  final _contactNumberController = TextEditingController();

  @override
  void dispose() {
    _contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      StudentRegistrationBloc,
      StudentRegistrationState,
      String
    >(
      selector: (state) {
        if (state is EditProfileState) {
          _contactNumberController.text = state.student.number;
        }
        return '';
      },
      builder: (context, state) {
        return CommonTextField(
          labelText: 'Contact Number',
          controller: _contactNumberController,
          keyboardType: TextInputType.phone,
          validator: AppValidator.validateNumber,
          onChanged: (value) =>
              context.read<StudentRegistrationBloc>().add(Phone(phone: value)),
        );
      },
    );
  }
}

// Email part
class StudentEmail extends StatelessWidget {
  const StudentEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text("Email", style: textTheme.bodyMedium);
  }
}

class StudentEmailTextField extends StatefulWidget {
  const StudentEmailTextField({super.key});

  @override
  State<StudentEmailTextField> createState() => _StudentEmailTextFieldState();
}

class _StudentEmailTextFieldState extends State<StudentEmailTextField> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      StudentRegistrationBloc,
      StudentRegistrationState,
      String
    >(
      selector: (state) {
        if (state is EditProfileState) {
          _emailController.text = state.student.email;
        }
        return '';
      },
      builder: (context, state) {
        return CommonTextField(
          labelText: 'Email',
          controller: _emailController,
          validator: AppValidator.validateEmail,
          onChanged: (value) =>
              context.read<StudentRegistrationBloc>().add(Email(email: value)),
        );
      },
    );
  }
}

// name part
class StudentName extends StatelessWidget {
  const StudentName({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text("Full Name", style: textTheme.bodyMedium);
  }
}

class StudentNameTextField extends StatefulWidget {
  const StudentNameTextField({super.key});

  @override
  State<StudentNameTextField> createState() => _StudentNameTextFieldState();
}

class _StudentNameTextFieldState extends State<StudentNameTextField> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      StudentRegistrationBloc,
      StudentRegistrationState,
      String
    >(
      selector: (state) {
        if (state is EditProfileState) {
          _nameController.text = state.student.name;
        }
        return '';
      },
      builder: (context, state) {
        return CommonTextField(
          labelText: 'Full Name',
          controller: _nameController,
          validator: AppValidator.validateName,
          onChanged: (value) =>
              context.read<StudentRegistrationBloc>().add(Name(name: value)),
        );
      },
    );
  }
}

// title
class StudentRegistrationText extends StatelessWidget {
  const StudentRegistrationText({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Text("Student Registration", style: textTheme.bodyLarge),
    );
  }
}
