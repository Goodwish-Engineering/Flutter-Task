import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_profile/edit_profile.dart';
import 'package:student_profile/helper/student_model.dart';
import 'package:student_profile/helper/student_provider.dart';
import 'package:student_profile/register.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  //delete profile confirmation
  void _deleteConfirmation(){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Delete Profile'),
          content: const Text('Are you sure you want to delete your profile?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color.fromARGB(255, 45, 69, 134)),
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<StudentProvider>(context, listen: false).clearStudent();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context).student;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 105,140,226),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: student == null
      ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(
             horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.009,
            ),
            child: Text(
              'Oops! Looks like you are not registered yet. \n Press the button below to register.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
            }, 
            style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: Color.fromARGB(255,45,69,134),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Register Now',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,),
            )
            ),
        ],
      ) : 
      Padding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // profile image
              if (student.profileImagePath.isNotEmpty)
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(File(student.profileImagePath)),
                ),
              ),
              
              if (student.profileImagePath.isEmpty)
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(
                    'lib/images/default_pfp.jpeg',
                  ),
                ),
              ),
        
              // full name 
              const SizedBox(height: 10),
              Center(
                child: Text(
                  '${student.fullName}',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        
              // edit profile button

                 GestureDetector(
                   onTap: () {
                     // Navigate to edit profile page
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) => EditProfile(student: student),
                       ),
                     );
                   },
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Icon(
                        Icons.edit,
                        color: Colors.white70,
                        size: 16,
                      )
                    ],
                                   ),
                 ),
        
              // email
              SizedBox(height: screenHeight * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 24,
                      ),
                       SizedBox(width: screenWidth * 0.02),
                       Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                       )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '${student.email}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
        
              // contact number
              Divider(color: Colors.white54),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '${student.contactNumber}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
        
              // date of birth
              Divider(color: Colors.white54),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        'Date of Birth',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '${student.dateOfBirth}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
        
              // gender
              Divider(color: Colors.white54),
              SizedBox(height: screenHeight * 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        'Gender',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    '${student.gender}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
        
              // button to clear student data
              SizedBox(height: screenHeight * 0.06),
              Center(
                child: ElevatedButton(
                  onPressed: _deleteConfirmation,
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Color.fromARGB(255, 45, 69, 134),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Delete Profile',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          ),
        ),
        );
  }
}