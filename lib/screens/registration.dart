import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/components/my_text_field.dart';
import 'package:task/components/unfocus_on_tap.dart';
import 'package:task/constants/const_var.dart';

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

  bool _canSubmit = false;

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
    final bool isValid =
        EmailValidator.validate(_emailController.text) &&
        _fullNameController.text.isNotEmpty &&
        _contactNumberController.text.isNotEmpty &&
        _dobController.text.isNotEmpty &&
        _pickedImage != null;

    if (_canSubmit != isValid) {
      setState(() {
        _canSubmit = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return UnFocusOnTap(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: const Text('Register', style: TextStyle(color: Colors.black)),
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
                MyTextField(
                  controller: _fullNameController,
                  hintText: 'Full Name',
                  textInputType: TextInputType.text,
                ),
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                MyTextField(
                  controller: _contactNumberController,
                  hintText: 'Contact Number',
                  textInputType: TextInputType.phone,
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Visibility(
                    visible: _canSubmit,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                        ),
                        onPressed: () {},
                        label: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(Icons.check, color: Colors.white),
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
