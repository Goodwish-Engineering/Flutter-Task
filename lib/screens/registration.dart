import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:task/components/my_text_field.dart';
import 'package:task/components/unfocus_on_tap.dart';
import 'package:task/constants/const_var.dart';
import 'package:task/models/student.dart';
import 'package:task/provider/student_provider.dart';
import 'package:task/screens/display.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _contactNumberController;
  late final TextEditingController _dobController;
  File? _pickedImage;
  String? _selectedGender;
  final List<String> _genders = <String>['Male', 'Female', 'Other'];

  bool _canSubmit = false;

  bool _isFullNameValid = false;
  bool _isEmailValid = false;
  bool _isContactValid = false;
  bool _isDobValid = false;
  bool _isGenderValid = false;
  bool _isImagePicked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _contactNumberController = TextEditingController();
    _dobController = TextEditingController();

    _fullNameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _contactNumberController.addListener(_validateForm);
    _dobController.addListener(_validateForm);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _fullNameController.dispose();
    _emailController.dispose();
    _contactNumberController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? _image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  void _validateForm() {
    setState(() {
      _isFullNameValid = _fullNameController.text.trim().isNotEmpty;
      _isEmailValid = EmailValidator.validate(_emailController.text.trim());
      _isContactValid = _contactNumberController.text.trim().isNotEmpty;
      _isDobValid = _dobController.text.trim().isNotEmpty;
      _isGenderValid = _selectedGender != null;
      _isImagePicked = _pickedImage != null;

      _canSubmit =
          _isFullNameValid &&
          _isEmailValid &&
          _isContactValid &&
          _isDobValid &&
          _isGenderValid &&
          _isImagePicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    // for persisting the state while editing
    final Student? alreadyFilledStudent = Provider.of<StudentProvider>(
      context,
      listen: false,
    ).student;

    if (alreadyFilledStudent != null) {
      _fullNameController.text = alreadyFilledStudent.fullName;
      _emailController.text = alreadyFilledStudent.email;
      _contactNumberController.text = alreadyFilledStudent.contactNumber;
      _dobController.text = alreadyFilledStudent.dateOfBirth;
      _selectedGender = alreadyFilledStudent.gender;
      _pickedImage = File(alreadyFilledStudent.profilePath);
      _canSubmit = true;
    }

    return UnFocusOnTap(
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            title: const Text(
              'Register',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: appBarColor,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 30),
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.white30,
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: appBarColor,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage!)
                              : null,
                          child: _pickedImage == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  size: 40,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  if (!_isImagePicked)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Please select a profile image.',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  MyTextField(
                    controller: _fullNameController,
                    hintText: 'Full Name',
                    textInputType: TextInputType.text,
                  ),
                  if (!_isFullNameValid)
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Full name cannot be empty.',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  MyTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                  ),
                  if (!_isEmailValid)
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter a valid email.',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  MyTextField(
                    controller: _contactNumberController,
                    hintText: 'Contact Number',
                    textInputType: TextInputType.phone,
                  ),
                  if (!_isContactValid)
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter a valid Contact Number.',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _dobController,
                      autocorrect: false,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2040),
                        );

                        if (pickedDate != null) {
                          _dobController.text =
                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        }
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Date-Of-Birth',
                        labelStyle: const TextStyle(color: Colors.black),
                        hintText: 'Enter your Date Of Birth',
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  if (!_isDobValid)
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Enter a valid Date Of Birth.',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      child: DropdownButtonFormField<String>(
                        value: _selectedGender,
                        items: _genders
                            .map(
                              (String gender) => DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender),
                              ),
                            )
                            .toList(),
                        onChanged: (String? newGender) {
                          setState(() {
                            _selectedGender = newGender;
                            _validateForm();
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          labelStyle: const TextStyle(color: Colors.black),
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        dropdownColor: Colors.white,
                      ),
                    ),
                  ),
                  if (!_isGenderValid)
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Please select a gender.',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                        ),
                        onPressed: () {
                          final Student student = Student(
                            fullName: _fullNameController.text.trim(),
                            email: _emailController.text.trim(),
                            contactNumber: _contactNumberController.text.trim(),
                            dateOfBirth: _dobController.text.trim(),
                            profilePath: _pickedImage!.path,
                            gender: _selectedGender!,
                          );

                          Provider.of<StudentProvider>(
                            context,
                            listen: false,
                          ).setStudent(student);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Student profile saved successfully!',
                              ),
                            ),
                          );

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute<Widget>(
                              builder: (BuildContext context) =>
                                  const DisplayScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        label: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(Icons.check, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
