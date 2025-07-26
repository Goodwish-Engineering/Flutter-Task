 
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';  
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:task/core/cubit/theme_toggle_cubit.dart';
import 'package:task/core/models/hive/student.dart';
import 'package:task/core/utils/size_extension.dart';
import 'package:task/features/presentation/bloc/student_bloc.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  String? _gender;
  String? _profilePicturePath;

  void _loadStudentData() {
    context.read<StudentBloc>().add(LoadStudent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
     
    _loadStudentData();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _contactNumberController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePicturePath = pickedFile.path;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_profilePicturePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload a profile picture'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_gender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your gender'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final student = Student(
        fullName: _fullNameController.text,
        email: _emailController.text,
        contactNumber: _contactNumberController.text,
        dateOfBirth: _dateOfBirthController.text,
        gender: _gender,
        profilePicturePath: _profilePicturePath,
      );

      context.read<StudentBloc>().add(SaveStudent(student));
    }
  }

  Widget _buildThemeToggle() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).primaryColor.withValues(alpha:  0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wb_sunny,
                size: 20,
                color: themeState.themeMode == AppThemeMode.light 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 8),
              Switch(
                value: themeState.themeMode == AppThemeMode.dark,
                onChanged: (value) {
                  context.read<ThemeCubit>().toggleTheme(context);
                },
                activeColor: Theme.of(context).primaryColor,
                inactiveThumbColor: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.nights_stay,
                size: 20,
                color: themeState.themeMode == AppThemeMode.dark 
                    ? Theme.of(context).primaryColor 
                    : Colors.grey.withValues(alpha: 0.6),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileImagePicker() {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).cardColor,
              backgroundImage: _profilePicturePath != null
                  ? FileImage(File(_profilePicturePath!))
                  : null,
              child: _profilePicturePath == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Add Photo',
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tap to upload profile picture',
          
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentLoaded) {
          final student = state.student;
          _fullNameController.text = student.fullName ?? '';
          _emailController.text = student.email ?? '';
          _contactNumberController.text = student.contactNumber ?? '';
          _dateOfBirthController.text = student.dateOfBirth ?? '';
          _gender = student.gender;
          _profilePicturePath = student.profilePicturePath;
        } else if (state is StudentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        } else if (state is StudentSaveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamed(context, '/profile').then((_) {
             
            _loadStudentData();
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Student Registration'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: _buildThemeToggle(),
            ),
          ],
        ),
        body: Padding(
          padding:   EdgeInsets.all(context.verticalPadding),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(context.horizontalPadding),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildProfileImagePicker(),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),

                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _contactNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Contact Number',
                      prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact number';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit contact number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _dateOfBirthController,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your date of birth';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _gender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    items: ['Male', 'Female', 'Other']
                        .map(
                          (gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<StudentBloc, StudentState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: state is StudentLoading ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: state is StudentLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Submit Registration',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}