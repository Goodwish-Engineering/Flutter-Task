import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_detail/Screens/SplashScreen.dart';
import 'Provider/Student_Provider.dart';
import 'screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final studentProvider = StudentProvider();
  await studentProvider.loadStudent();
  runApp(
    ChangeNotifierProvider(
      create: (_) => StudentProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
