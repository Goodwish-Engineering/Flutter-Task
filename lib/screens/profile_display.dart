import 'package:flutter/material.dart';
import 'dart:io';
import 'registration_page.dart';

class ProfileDisplayPage extends StatelessWidget {
  final String name;
  final String email;
  final String contact;
  final String dob;
  final String gender;
  final File? profileImage;

  const ProfileDisplayPage({
    super.key,
    required this.name,
    required this.email,
    required this.gender,
    required this.dob,
    required this.contact,
    this.profileImage,
  });

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Profile?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.popUntil(ctx, (route) => route.isFirst);
              ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(content: Text('Profile deleted!')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          'Student Profile App',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                    profileImage != null ? FileImage(profileImage!) : null,
                child: profileImage == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            _infoRow('Name:', name),
            _infoRow('Email:', email),
            _infoRow('Contact:', contact),
            _infoRow('Date of Birth:', dob),
            _infoRow('Gender:', gender),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentRegistrationPage(
                          initialName: name,
                          initialEmail: email,
                          initialContact: contact,
                          initialDob: dob,
                          initialGender: gender,
                          initialImage: profileImage,
                        ),
                      ),
                    );
                  },
                  child: const Text('✏️ Edit'),
                ),
                ElevatedButton(
                  onPressed: () => _confirmDelete(context),
                  child: const Text('🗑️ Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Flexible(child: Text(value)),
        ],
      ),
    );
  }
}
