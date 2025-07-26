import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:studentprofileapp/common/theme/app_theme.dart';
import 'package:studentprofileapp/features/student_details/bloc/studentdetails_bloc.dart';
import 'package:studentprofileapp/features/student_registration/bloc/student_registration_bloc.dart';
import 'package:studentprofileapp/routes/app_pages.dart';
import 'package:studentprofileapp/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StudentRegistrationBloc()),
        BlocProvider(create: (context) => StudentdetailsBloc()),
      ],
      child: ScreenUtilInit(
        designSize: Size(375, 812), // size

        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => MaterialApp(
          title: 'Student profile app',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.studentRegistration,
          onGenerateRoute: onGenerateRoute,
          darkTheme: AppTheme.darkTheme,
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.system,
          home: SizedBox(),
        ),
      ),
    );
  }
}
