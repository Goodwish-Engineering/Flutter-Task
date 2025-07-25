import 'package:flutter/material.dart';
import 'package:flutter_task/provider/student_provider.dart';
import 'package:flutter_task/screens/student_registration_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Task',
         // -- THEME CONFIGURATION --

      // Defining the Light Theme
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
      ),

      // Defining the Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark, 
        ),
      ),
 
      // theme based on the user's phone settings.
      themeMode: ThemeMode.system,

        home: StudentRegistrationScreen(),
      ),
    );
  }
}
 