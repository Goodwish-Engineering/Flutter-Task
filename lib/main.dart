import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/student_registration_screen.dart';
import 'screens/profile_display_screen.dart';
import 'providers/student_provider.dart';
import 'providers/theme_provider.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Student Profile App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const AppWrapper(),
          );
        },
      ),
    );
  }
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, studentProvider, child) {
        if (studentProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (studentProvider.hasStudent) {
          return const ProfileDisplayScreen();
        } else {
          return const StudentRegistrationScreen();
        }
      },
    );
  }
}
