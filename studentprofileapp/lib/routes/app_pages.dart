// route
import 'package:flutter/material.dart';
import 'package:studentprofileapp/features/student_details/screen/student_details_screen.dart';
import 'package:studentprofileapp/features/student_registration/screen/student_registration_screen.dart';
import 'package:studentprofileapp/routes/app_routes.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.studentRegistration:
      return MaterialPageRoute(builder: (_) => StudentRegistrationScreen());
    case AppRoutes.studentDetails:
      return MaterialPageRoute(builder: (_) => StudentDetailsScreen());

    default:
      return MaterialPageRoute(builder: (_) => StudentRegistrationScreen());
  }
}
