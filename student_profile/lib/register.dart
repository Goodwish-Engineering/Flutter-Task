import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:student_profile/components/my_textfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  File? _selectedImage;
  String? _imagePath;
  String? _selectedGender;

  // controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  // form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // image picker function
  Future<void> _pickImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      _selectedImage = File(pickedFile.path);
      _imagePath = pickedFile.path;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,105,140,226),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
          
              // Profile Pivture
              Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: 
                      _selectedImage != null ? FileImage(_selectedImage!) : null,
                      child: _selectedImage == null
                          ? const Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.blue,
                          ) : null
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Select your Profile Picture',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                    ),
                  )
                ],
              ),
          
              // Full Name 
              const SizedBox(height: 20),
              MyTextField(
                controller: _fullNameController,
                hint: 'Full Name',
                validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
              ),
          
              // Email
              const SizedBox(height: 10),
              MyTextField(
                controller: _emailController,
                hint: 'Email',
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
              ),
          
              // Contact Number
              const SizedBox(height: 10),
              MyTextField(
                controller: _contactNumberController,
                hint: 'Contact Number',
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter your contact number' : null,
              ),
          
              // Date of Birth
              const SizedBox(height: 10),
              MyTextField(
                controller: _dateOfBirthController,
                hint: 'Date of Birth',
                keyboardType: TextInputType.none,
                onTap: () async {
                  // date picker 
                  FocusScope.of(context).unfocus();
                  DateTime? pickedDate = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900), 
                    lastDate: DateTime.now(),
                    builder: (BuildContext context, Widget? child){
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Color.fromARGB(255, 0, 122, 255),
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            )
                          )
                        ), 
                        child: child!
                        );
                    }
                  );
                  if (pickedDate != null) {
                    _dateOfBirthController.text = '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                  }
                },
                validator: (value) => value!.isEmpty ? 'Please select your date of birth' : null,
              ),
      
              // Gender Selection
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: DropdownButtonFormField<String>(
                  hint: Text(
                    'Select Gender',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                  dropdownColor: Color.fromARGB(255, 255, 255, 255), 
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 223, 242, 254),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color.fromARGB(255, 8, 80, 128)),
                      ),
                    ),
                  value: _selectedGender,
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                        )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select your gender' : null,
                ),
              ),
      
              // submit button
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Color.fromARGB(255, 45, 69, 134),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the data
                    print('Full Name: ${_fullNameController.text}');
                    print('Email: ${_emailController.text}');    
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}