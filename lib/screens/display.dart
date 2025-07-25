import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/components/unfocus_on_tap.dart';
import 'package:task/constants/const_var.dart';
import 'package:task/models/student.dart';
import 'package:task/provider/student_provider.dart';
import 'package:task/screens/registration.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({super.key});

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(value, style: const TextStyle(fontSize: 15)),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Data Deletion Confirmation'),
        content: const Text('Are you sure you want to delete?'),
        contentPadding: const EdgeInsets.all(20.0),
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: const Text('Cancel!'),
            icon: const Icon(Icons.cancel_outlined),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<Widget>(
                  builder: (BuildContext context) => const RegistrationScreen(),
                ),
                (Route<dynamic> route) => false,
              );
              Provider.of<StudentProvider>(
                context,
                listen: false,
              ).clearStuent();
            },
            label: const Text('Yes!'),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Student? student = Provider.of<StudentProvider>(context).student;
    if (student == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return UnFocusOnTap(
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: appBarColor,
            title: const Text(
              "Student's Profile",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(File(student!.profilePath)),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoRow('Full Name', student.fullName),
                  _buildInfoRow('Email', student.email),
                  _buildInfoRow('Contact Number', student.contactNumber),
                  _buildInfoRow('Date of Birth', student.dateOfBirth),
                  _buildInfoRow('Gender', student.gender),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute<Widget>(
                              builder: (BuildContext context) =>
                                  const RegistrationScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        label: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.black),
                        ),
                        icon: const Icon(Icons.edit, color: Colors.black),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showDeleteDialog(context);
                        },
                        label: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
