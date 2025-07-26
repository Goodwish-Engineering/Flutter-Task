import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/App_Colors.dart';
import '../Provider/Student_Provider.dart';
import 'profile_screen.dart';
import 'registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      _loadStudentData();
    });
  }

  Future<void> _loadStudentData() async {
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    await studentProvider.loadStudent();

    if (studentProvider.student != null) {
      // Navigate to ProfileScreen if student data exists
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileScreen()),
      );
    } else {
      // Navigate to RegistrationScreen if no data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegistrationScreen()),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/std.png', // path matches your image location
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }


}
