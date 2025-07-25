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

  // for dispaying error messages
  bool _isFullNameTouched = false;
  bool _isEmailTouched = false;
  bool _isContactTouched = false;
  bool _isDobTouched = false;
  bool _isGenderTouched = false;
  bool _isImageTouched = false;

  bool _isPickingImage = false;

  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final StudentProvider studentProvider = Provider.of<StudentProvider>(
        context,
        listen: false,
      );
      final Student? alreadyFilledStudent = studentProvider.student;

      if (alreadyFilledStudent != null) {
        _fullNameController.text = alreadyFilledStudent.fullName;
        _emailController.text = alreadyFilledStudent.email;
        _contactNumberController.text = alreadyFilledStudent.contactNumber;
        _dobController.text = alreadyFilledStudent.dateOfBirth;
        _selectedGender = alreadyFilledStudent.gender;
        _pickedImage = File(alreadyFilledStudent.profilePath);
      } else {
        _fullNameController.clear();
        _emailController.clear();
        _contactNumberController.clear();
        _dobController.clear();
        _selectedGender = null;
        _pickedImage = null;
      }

      _validateForm();
      _isInitialized = true;
    }
  }

  @override
  void initState() {
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
    _fullNameController.dispose();
    _emailController.dispose();
    _contactNumberController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_isPickingImage) return;

    setState(() {
      _isPickingImage = true;
      _isImageTouched = true;
    });

    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        setState(() {
          _pickedImage = File(image.path);
        });
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
    } finally {
      setState(() {
        _isPickingImage = false;
      });
      _validateForm();
    }
  }

  void _validateForm() {
    final bool isFullNameValid = _fullNameController.text.trim().isNotEmpty;
    final bool isEmailValid = EmailValidator.validate(
      _emailController.text.trim(),
    );
    final bool isContactValid = _contactNumberController.text.trim().isNotEmpty;
    final bool isDobValid = _dobController.text.trim().isNotEmpty;
    final bool isGenderValid = _selectedGender != null;
    final bool isImagePicked = _pickedImage != null;

    setState(() {
      _canSubmit =
          isFullNameValid &&
          isEmailValid &&
          isContactValid &&
          isDobValid &&
          isGenderValid &&
          isImagePicked;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  if (!_isImageTouched && _pickedImage == null)
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
                    onTap: () {
                      setState(() => _isFullNameTouched = true);
                    },
                  ),
                  if (_isFullNameTouched &&
                      _fullNameController.text.trim().isEmpty)
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
                    onTap: () {
                      setState(() => _isEmailTouched = true);
                    },
                  ),
                  if (_isEmailTouched &&
                      !EmailValidator.validate(_emailController.text.trim()))
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
                    onTap: () {
                      setState(() => _isContactTouched = true);
                    },
                  ),
                  if (_isContactTouched &&
                      _contactNumberController.text.trim().isEmpty)
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
                        setState(() => _isDobTouched = true);
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
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
                  if (_isDobTouched && _dobController.text.trim().isEmpty)
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
                            _isGenderTouched = true;
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
                  if (_isGenderTouched && _selectedGender == null)
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
                        onPressed: _canSubmit
                            ? () {
                                final Student student = Student(
                                  fullName: _fullNameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  contactNumber: _contactNumberController.text
                                      .trim(),
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
                              }
                            : null,
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
