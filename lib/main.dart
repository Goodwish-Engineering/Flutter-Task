import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/provider/student_provider.dart';
import 'package:task/screens/display.dart';
import 'package:task/screens/registration.dart';

void main() {
  runApp(
    ChangeNotifierProvider<StudentProvider>(
      create: (BuildContext context) => StudentProvider(),
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
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const RegistrationScreen(),
        '/display': (BuildContext context) => const DisplayScreen(),
      },
    );
  }
}