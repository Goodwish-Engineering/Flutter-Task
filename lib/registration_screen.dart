import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedGender;
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _profileImage = File(picked.path));
    }
  }

  bool _isEmailValid(String email) {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return regex.hasMatch(email);
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (_profileImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please choose a profile image')),
        );
        return;
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', _nameController.text);
      await prefs.setString('user_email', _emailController.text);
      await prefs.setString('user_password', _passwordController.text);
      await prefs.setString('user_contact', _contactController.text);
      await prefs.setString('user_dob', _dobController.text);
      await prefs.setString('user_gender', _selectedGender ?? '');
      await prefs.setString('user_profile_image', _profileImage?.path ?? '');

      final userData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'contact': _contactController.text,
        'dob': _dobController.text,
        'gender': _selectedGender,
        'profileImagePath': _profileImage?.path ?? '',
      };

      Navigator.pushReplacementNamed(context, '/profile', arguments: userData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text('R E G I S T E R', style: TextStyle(fontSize: 22)),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Choose Your Image'),
        
                // Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Enter your name' : null,
                ),
        
                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your email';
                    }
                    if (!_isEmailValid(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(
                    labelText: 'Contact',
                    hintText: 'Enter digits only (e.g. 9841234567)',
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter contact number';
                    if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                      return 'Contact must be 10-15 digits';
                    }
                    return null;
                  },
                ),

// DOB field with input formatter and validator:
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: 'DOB',
                    hintText: 'YYYY-MM-DD',
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter your date of birth';
                    // Regex for YYYY-MM-DD format:
                    final dobRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                    if (!dobRegex.hasMatch(value)) {
                      return 'Date must be in YYYY-MM-DD format';
                    }
                    try {
                      DateTime dob = DateTime.parse(value);
                      if (dob.isAfter(DateTime.now())) {
                        return 'DOB cannot be in the future';
                      }
                    } catch (e) {
                      return 'Invalid date';
                    }
                    return null;
                  },
                ),
                // Gender
                DropdownButtonFormField<String>(
                  value: _selectedGender,
                  items: const [
                    DropdownMenuItem(value: 'Male', child: Text('Male')),
                    DropdownMenuItem(value: 'Female', child: Text('Female')),
                    DropdownMenuItem(value: 'Other', child: Text('Other')),
                  ],
                  onChanged: (val) => setState(() => _selectedGender = val),
                  decoration: const InputDecoration(labelText: 'Gender'),
                  validator: (value) =>
                  value == null ? 'Please select gender' : null,
                ),
        
                // Password
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) =>
                  value == null || value.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
        
                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Re-enter your password' : null,
                ),
        
                const SizedBox(height: 30),
        
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _registerUser,
                    child: const Text('Register'),
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
