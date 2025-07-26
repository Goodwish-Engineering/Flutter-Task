import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/components/my_textfield.dart';
import 'package:student_profile/dashboard.dart';
import 'package:student_profile/helper/student_model.dart';
import 'package:student_profile/helper/student_provider.dart';

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

// success message dialog
void _showSuccessDialog(){
  showDialog(
    context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Image.asset(
          'lib/images/success.png',
          width: 100,
          height: 100,
          alignment: Alignment.center,
        ),
        content: const Text(
          'YAYY! Your student profile has been created successfully.',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
          ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const Dashboard())
              );
            },
            child: const Text(
              'Go to Dashboard',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 0, 122, 255),
              ),
              ),
          ),
        ],
      );
    }
    );
}

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

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
              SizedBox(height: screenHeight * 0.04),

              // Profile Picture
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

                  // edit profile picture text
                  SizedBox(height: screenHeight * 0.01,),
                  Text(
                    'Select your Profile Picture',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                    ),
                  )
                ],
              ),
          
              // Full Name 
              SizedBox(height: screenHeight * 0.01),
              MyTextField(
                controller: _fullNameController,
                hint: 'Full Name',
                validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
              ),
          
              // Email
              SizedBox(height: screenHeight * 0.01),
              MyTextField(
                controller: _emailController,
                hint: 'Email',
                validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
              ),
          
              // Contact Number
              SizedBox(height: screenHeight * 0.01),
              MyTextField(
                controller: _contactNumberController,
                hint: 'Contact Number',
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter your contact number' : null,
              ),
          
              // Date of Birth
              SizedBox(height: screenHeight * 0.01),
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
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.01),
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                      // listening to the provider 
                      Provider.of<StudentProvider>(context, listen: false).setStudent(
                        StudentModel(
                          fullName: _fullNameController.text, 
                          email: _emailController.text, 
                          contactNumber: _contactNumberController.text, 
                          dateOfBirth: _dateOfBirthController.text, 
                          gender: _selectedGender ?? 'Not specified', 
                          profileImagePath: _imagePath ?? '',
                        ),
                      );
                    // show success dialog
                    _showSuccessDialog();
                    // Process the data
                    debugPrint('Full Name: ${_fullNameController.text}');
                    debugPrint('Email: ${_emailController.text}');
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