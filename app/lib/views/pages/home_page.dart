import 'package:app/config/app_palette.dart';
import 'package:app/config/app_routes.dart';
import 'package:app/model/gender_type_enum.dart';
import 'package:app/views/bloc/student_bloc.dart';
import 'package:app/views/widgets/profile_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Helper method to get gender icon based on gender type
  Icon _getGenderIcon(Gender gender) {
    switch (gender) {
      case Gender.MALE:
        return Icon(Icons.male, size: 24, color: Colors.blue);
      case Gender.FEMALE:
        return Icon(Icons.female, size: 24, color: Colors.pink);
      default:
        return Icon(Icons.transgender, size: 24, color: Colors.grey);
    }
  }

  ImageProvider _getGenderImage(Gender gender) {
    switch (gender) {
      case Gender.MALE:
        return AssetImage('assets/images/man.jpg');
      case Gender.FEMALE:
        return AssetImage('assets/images/girl.jpeg');
      default:
        return AssetImage('assets/images/third.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is StudentEditState) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.REGISTER);
        }
      },
      child: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentRegisterSuccessState) {
            final student = state.student;
            final genderIcon = _getGenderIcon(student.gender);
            final genderImage = _getGenderImage(student.gender);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text('Registered User'),
                elevation: 0,
              ),
              backgroundColor: Colors.white,
              body: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header section with avatar and title
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                state.student.profilePicture != null
                                    ? FileImage(state.student.profilePicture!)
                                    : _getGenderImage(student.gender),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Student Detail',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Vintaface',
                              letterSpacing: 8,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    // Profile details
                    ProfileDetail(placeholder: 'Name', value: student.fullName),
                    SizedBox(height: 16),

                    ProfileDetail(
                      placeholder: 'Email',
                      value: student.email,
                      canCopy: true,
                    ),
                    SizedBox(height: 16),

                    ProfileDetail(
                      placeholder: 'Contact',
                      value: student.contactNumber,
                      canCopy: true,
                    ),
                    SizedBox(height: 16),

                    ProfileDetail(
                      placeholder: 'Gender',
                      value: student.gender.displayName,
                      isGender: true,
                      genderIcon: genderIcon,
                    ),
                    SizedBox(height: 16),

                    ProfileDetail(
                      placeholder: 'DOB',
                      value: student.dob.toIso8601String(),
                      isDob: true,
                    ),
                    SizedBox(height: 16),

                    Spacer(),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<StudentBloc>().add(
                            StudentEditRegistrationEvent(student: student),
                          );
                        },
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(
                'No student data available',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            ),
          );
        },
      ),
    );
  }
}
