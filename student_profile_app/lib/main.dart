import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:student_profile_app/provider/student_provider.dart';
import 'package:student_profile_app/screens/student_registration_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, studentProvider, child) {
        return MaterialApp(
          title: 'Student Profile App',
          themeMode: studentProvider.isDarkTheme!
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: ThemeData(
            textTheme: GoogleFonts.lailaTextTheme(),
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          ),
          darkTheme: ThemeData(
            textTheme: GoogleFonts.lailaTextTheme(
              ThemeData(brightness: Brightness.dark).textTheme,
            ),
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
          ),
          home: const StudentRegistrationScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
