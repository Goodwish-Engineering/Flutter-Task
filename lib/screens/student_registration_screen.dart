import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_task/models/student_model.dart';
import 'package:flutter_task/provider/student_provider.dart';
import 'package:flutter_task/screens/student_profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class StudentRegistrationScreen extends StatefulWidget {
  final bool? editMode;

  const StudentRegistrationScreen({super.key, this.editMode});

  @override
  State<StudentRegistrationScreen> createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  // A GlobalKey for the form to handle validation
  final _formKey = GlobalKey<FormState>();

  // Text editing controllers for the form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  Gender? _gender;
  File? _profilePicture;

  @override
  void initState() {
    super.initState();
    // Use a post-frame callback to safely access the Provider context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStudentData();
    });
  }

  void _loadStudentData() {
    // If in edit mode, load existing student data from the provider
    if (widget.editMode == true) {
      Student? student =
          Provider.of<StudentProvider>(context, listen: false).student;
      if (student != null) {
        setState(() {
          _fullNameController.text = student.fullName;
          _emailController.text = student.email;
          _contactController.text = student.contactNumber;
          _dobController.text = student.dob.toIso8601String().split('T').first;
          _gender = student.gender;
          _profilePicture = student.profilePicture;
        });
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _fullNameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  /// Opens the image picker to select a profile picture from the gallery.
  Future<void> _selectProfilePicture() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  /// Validates the form and saves the student data.
  void _saveStudentData() {
    // First, validate the form. If it's not valid, do nothing.
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_profilePicture == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a profile picture')),
      );
      return;
    }

    // If the form is valid, proceed to save the data.
    final student = Student(
      fullName: _fullNameController.text,
      email: _emailController.text,
      contactNumber: _contactController.text,
      dob: DateTime.parse(_dobController.text),
      profilePicture: _profilePicture!,
      gender: _gender!,
    );

    // Use the provider to set the student data globally
    Provider.of<StudentProvider>(context, listen: false).setStudent(student);

    // Navigate to the profile screen, replacing the current screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const StudentProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editMode == true ? 'Edit Profile' : 'Student Registration'),
      ),
      body: Center(
        child: ConstrainedBox(
          // For responsiveness on wider screens
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    _buildProfilePicture(),
                    const SizedBox(height: 32),
                    _buildFullNameField(),
                    const SizedBox(height: 16),
                    _buildEmailField(),
                    const SizedBox(height: 16),
                    _buildContactField(),
                    const SizedBox(height: 16),
                    _buildDobField(context),
                    const SizedBox(height: 16),
                    _buildGenderDropdown(),
                    const SizedBox(height: 40),
                    _buildSaveButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the interactive profile picture widget.
  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 60,
            // Use a theme color for the background
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            backgroundImage:
                _profilePicture != null ? FileImage(_profilePicture!) : null,
            child: _profilePicture == null
                ? Icon(
                    Icons.person,
                    size: 60,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  )
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: _selectProfilePicture,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the Full Name text form field.
  Widget _buildFullNameField() {
    return TextFormField(
      controller: _fullNameController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person_outline),
        labelText: 'Full Name',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        return null;
      },
    );
  }

  /// Builds the Email text form field.
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        // Optional: Add more robust email validation
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  /// Builds the Contact Number text form field.
  Widget _buildContactField() {
    return TextFormField(
      controller: _contactController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.phone_outlined),
        labelText: 'Contact Number',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your contact number';
        }
        return null;
      },
    );
  }

  /// Builds the Date of Birth text form field with a date picker.
  Widget _buildDobField(BuildContext context) {
    return TextFormField(
      controller: _dobController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.calendar_today_outlined),
        labelText: 'Date of Birth',
        border: OutlineInputBorder(),
      ),
      readOnly: true, // Prevents keyboard from appearing
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          // Format the date and set it to the controller
          _dobController.text = pickedDate.toIso8601String().split('T').first;
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your date of birth';
        }
        return null;
      },
    );
  }

  /// Builds the Gender dropdown form field.
  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<Gender>(
      value: _gender,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.wc_outlined),
        labelText: 'Gender',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: Gender.male, child: Text('Male')),
        DropdownMenuItem(value: Gender.female, child: Text('Female')),
        DropdownMenuItem(value: Gender.other, child: Text('Other')),
      ],
      onChanged: (value) {
        setState(() {
          _gender = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }

  /// Builds the main Save button.
  Widget _buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        // Use theme colors for the button
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: _saveStudentData,
      child: Text(
        widget.editMode == true ? 'Update Profile' : 'Save',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}