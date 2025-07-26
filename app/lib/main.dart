import 'package:app/config/app_routes.dart';
import 'package:app/config/themes.dart';
import 'package:app/views/bloc/student_bloc.dart';
import 'package:app/views/pages/home_page.dart';
import 'package:app/views/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => StudentBloc())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registration App',
      theme: AppTheme.lightThemeMode,
      initialRoute: AppRoutes.REGISTER,
      routes: {
        AppRoutes.REGISTER: (context) => const RegisterPage(),
        AppRoutes.HOME: (context) => const HomePage(),
      },
    );
  }
}
