import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:hive_flutter/adapters.dart';
import 'package:task/core/cubit/theme_toggle_cubit.dart';
import 'package:task/core/models/hive/student.dart';
import 'package:task/features/data/repository/student_repository.dart';
import 'package:task/features/presentation/bloc/student_bloc.dart';
import 'package:task/features/presentation/screens/profile_screen.dart';
import 'package:task/features/presentation/screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('studentBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => StudentRepository(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => StudentBloc(
            studentRepository: RepositoryProvider.of<StudentRepository>(context),
          )..add(LoadStudent()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Student Profile',
            theme: context.read<ThemeCubit>().getThemeData(context),
            initialRoute: '/registration',
            routes: {
              '/registration': (context) => const RegistrationScreen(),
              '/profile': (context) => const ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}