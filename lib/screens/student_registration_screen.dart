import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:students_profile_app/widgets/profile_picker.dart';
import '../models/student.dart';
import '../providers/student_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/validators.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/phone_number_field.dart';
import 'profile_display_screen.dart';

class StudentRegistrationScreen extends StatefulWidget {
  final Student? studentToEdit;

  const StudentRegistrationScreen({Key? key, this.studentToEdit})
    : super(key: key);

  @override
  State<StudentRegistrationScreen> createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;
  String? _profilePicturePath;
  CountryCode? _selectedCountryCode;
  String _phoneNumber = '';

  final List<String> _genderOptions = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();

    // Initialize default country code
    _selectedCountryCode = Validators.countryCodes.first;

    if (widget.studentToEdit != null) {
      _populateFields(widget.studentToEdit!);
    }
  }

  void _populateFields(Student student) {
    _nameController.text = student.fullName;
    _emailController.text = student.email;
    _contactController.text = student.contactNumber;
    _phoneNumber = student.contactNumber;
    _selectedCountryCode = Validators.countryCodes.firstWhere(
      (country) => country.code == student.countryCode,
      orElse: () => Validators.countryCodes.first,
    );
    _selectedDate = student.dateOfBirth;
    _dobController.text = DateFormat('dd/MM/yyyy').format(student.dateOfBirth);
    _selectedGender = student.gender;
    _profilePicturePath = student.profilePicturePath;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate ??
          DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedCountryCode != null) {
      final student = Student(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        contactNumber: _phoneNumber.trim(),
        countryCode: _selectedCountryCode!.code,
        dialCode: _selectedCountryCode!.dialCode,
        dateOfBirth: _selectedDate!,
        gender: _selectedGender!,
        profilePicturePath: _profilePicturePath,
      );

      try {
        await context.read<StudentProvider>().saveStudent(student);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  widget.studentToEdit != null
                      ? 'Profile updated successfully!'
                      : 'Student registered successfully!',
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 2),
          ),
        );

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ProfileDisplayScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving student: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 30),
                        _buildRegistrationForm(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.studentToEdit != null
                  ? 'Edit Profile'
                  : 'Student Registration',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.studentToEdit != null
                  ? 'Update your information below'
                  : 'Create your student profile',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
        Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return IconButton(
              onPressed: () {
                final newMode = themeProvider.themeMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
                themeProvider.setThemeMode(newMode);
              },
              icon: Icon(
                themeProvider.themeMode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withOpacity(0.1),
                padding: const EdgeInsets.all(12),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ProfilePicturePicker(
                initialImagePath: _profilePicturePath,
                onImageSelected: (path) {
                  setState(() {
                    _profilePicturePath = path;
                  });
                },
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: 'Full Name *',
                hintText: 'Enter your full name',
                controller: _nameController,
                validator: Validators.validateName,
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Email Address *',
                hintText: 'Enter your email',
                controller: _emailController,
                validator: Validators.validateEmail,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),
              PhoneNumberField(
                label: 'Contact Number *',
                initialValue: _phoneNumber,
                initialCountryCode: _selectedCountryCode,
                onChanged: (phoneNumber, countryCode) {
                  setState(() {
                    _phoneNumber = phoneNumber;
                    _selectedCountryCode = countryCode;
                  });
                },
                validator: Validators.validateContactNumber,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: 'Date of Birth *',
                hintText: 'Select your date of birth',
                controller: _dobController,
                validator: (value) =>
                    Validators.validateDateOfBirth(_selectedDate),
                readOnly: true,
                onTap: _selectDate,
                prefixIcon: Icons.calendar_today_outlined,
              ),
              const SizedBox(height: 20),
              _buildGenderDropdown(),
              const SizedBox(height: 40),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender *',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedGender,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person_outline),
            hintText: 'Select your gender',
          ),
          validator: Validators.validateGender,
          items: _genderOptions.map((String gender) {
            return DropdownMenuItem<String>(value: gender, child: Text(gender));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedGender = newValue;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Consumer<StudentProvider>(
      builder: (context, studentProvider, child) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: studentProvider.isLoading ? null : _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: studentProvider.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.save),
                      const SizedBox(width: 8),
                      Text(
                        widget.studentToEdit != null
                            ? 'Update Profile'
                            : 'Register Student',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
