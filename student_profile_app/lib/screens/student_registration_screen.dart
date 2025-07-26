import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_profile_app/models/student.dart';
import 'package:student_profile_app/provider/student_provider.dart';
import 'package:student_profile_app/screens/student_profile_screen.dart';

class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedGender = 'Male';
  File? _profileImage;
  bool _isEditing = false;
  Student? _editingStudent;

  @override
  void initState() {
    super.initState();
    _loadStudentData();
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select the date of birth")),
      );
      return;
    }
    if (_profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pick the image from the gallery")),
      );
      return;
    }

    final student = Student(
      fullname: _nameController.text,
      email: _emailController.text,
      contactNumber: _contactController.text,
      dateOfBirth: _selectedDate!,
      gender: _selectedGender,
      profilePicturePath: _profileImage?.path,
    );

    final studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );

    if (_isEditing) {
      studentProvider.updateStudent(student);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Student Profile Updated Successfully")),
      );
    } else {
      studentProvider.saveStudent(student);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Student Profile Saved Successfully")),
      );
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const StudentProfileScreen()),
    );
  }

  void _loadStudentData() {
    final studentProvider = Provider.of<StudentProvider>(
      context,
      listen: false,
    );
    final student = studentProvider.student;

    if (student != null) {
      _isEditing = true;
      _editingStudent = student;
      _nameController.text = student.fullname;
      _emailController.text = student.email;
      _contactController.text = student.contactNumber;
      _selectedDate = student.dateOfBirth;
      _selectedGender = student.gender;
      if (student.profilePicturePath != null) {
        _profileImage = File(student.profilePicturePath!);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: studentProvider.toggleTheme,
          ),
        ],
        title: Text(_isEditing ? 'Edit Profile' : 'Register'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 85,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? const Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        backgroundColor: const Color.fromARGB(
                          255,
                          111,
                          44,
                          178,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _pickImage,
                      child: const Text(
                        'Upload Profile Picture',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 254, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter your name"
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value!.isEmpty) {
                      return "Please enter your valid email";
                    } else if (!value.contains('@') ||
                        !value.endsWith(".com")) {
                      return 'Please enter valid email address';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Contact Number',
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value!.isEmpty) {
                      return "Please enter your valid contact information";
                    } else if (value.length < 8) {
                      return 'contact number should be more than 8 character';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Date of Birth",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          style: TextStyle(
                            color: _selectedDate == null
                                ? Colors.grey
                                : const Color.fromARGB(255, 198, 198, 198),
                          ),
                        ),
                        Icon(Icons.calendar_today, size: 20),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedGender,
                      isExpanded: true,
                      items: ['Male', 'Female', 'Other'].map((gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _submitForm(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color.fromARGB(
                        255,
                        111,
                        44,
                        178,
                      ), // light blue
                      foregroundColor: const Color.fromARGB(255, 252, 252, 252),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: Text(_isEditing ? 'Update Profile' : 'Register'),
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
