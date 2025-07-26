import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_detail/Constants/App_Colors.dart';
import '../Models/Student_Model.dart';
import '../Provider/Student_Provider.dart';
import 'Profile_Screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';




class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  DateTime? _dob;
  String _gender = 'Male';
  File? _pickedImage;


  @override
  void initState() {
    super.initState();
    loadSavedData();
  }



  void _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }


  void loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final studentData = prefs.getString('student_data');

    if (studentData != null) {
      final studentJson = jsonDecode(studentData);
      final student = StudentModel.fromJson(studentJson);

      setState(() {
        _nameController.text = student.fullName;
        _emailController.text = student.email;
        _contactController.text = student.contact;
        _dob = student.dob;
        _gender = student.gender;
        _pickedImage = student.profileImage;
      });

      Provider.of<StudentProvider>(context, listen: false).setStudent(student);
    } else {
      // Data was deleted, clear form fields explicitly
      setState(() {
        _nameController.clear();
        _emailController.clear();
        _contactController.clear();
        _dob = null;
        _gender = 'Male';
        _pickedImage = null;
      });

      Provider.of<StudentProvider>(context, listen: false).clear();
    }
  }


  void _submit() async {
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose a profile picture'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate() && _dob != null) {
      final student = StudentModel(
        fullName: _nameController.text,
        email: _emailController.text,
        contact: _contactController.text,
        dob: _dob!,
        gender: _gender,
        profileImage: _pickedImage,
      );

      Provider.of<StudentProvider>(context, listen: false).setStudent(student);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('student_data', jsonEncode(student.toJson()));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile submitted successfully'),
        backgroundColor: Colors.green,),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }



  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              // Mobile layout
              return _buildFormContent(context, maxWidth: constraints.maxWidth * 0.95);
            } else {
              // Tablet layout: Center form, limit max width, add padding
              return Center(
                child: Container(
                  width: 600, // max width for tablet form
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: _buildFormContent(context, maxWidth: 600),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - 10,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
        validator: validator ?? (value) => value!.isEmpty ? 'Required' : null,
      ),
    );
  }


  Widget _buildFormContent(BuildContext context, {required double maxWidth}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 60),
            Center(
              child: Text(
                'Student Detail',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.lightGray,
                      backgroundImage:
                      _pickedImage != null ? FileImage(_pickedImage!) : null,
                      child: _pickedImage == null
                          ? const Icon(Icons.person, size: 50, color: Colors.black)
                          : null,
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text('Full Name',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black)),
                  const SizedBox(height: 6),
                  _buildTextField(controller: _nameController, hint: 'Enter name',),

                  const SizedBox(height: 10),


                  const Text('Email',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black)),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: _emailController,
                    hint: 'Enter email',
                    validator: (value) => !value!.contains('@gmail.com') ? 'Enter valid email' : null,
                  ),

                  const SizedBox(height: 10),

                  const Text('Phone No',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black)),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: _contactController,
                    hint: 'Enter phone number',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Required';
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return 'Enter a valid 10-digit number';
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),


                  Row(
                    children: [
                      Text(
                        _dob == null
                            ? 'Date of Birth:'
                            : 'Date of Birth: ${DateFormat.yMMMd().format(_dob!)}',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              _dob = picked;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(35, 35),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.blueGrey[100],
                        ),
                        child: const Icon(Icons.calendar_today,
                            size: 20, color: Colors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),


                  Row(
                    children: [
                      const Text(
                        'Gender:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 35,
                        width: 90,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: AppColors.lightGray,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _gender,
                          items: ['Male', 'Female', 'Other']
                              .map((e) => DropdownMenuItem(
                            value: e,
                            child: Center(child: Text(e,  style: const TextStyle(color: Colors.black), ),),
                          ))
                              .toList(),
                          onChanged: (value) => setState(() => _gender = value!),
                          iconEnabledColor: Colors.black,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



}
