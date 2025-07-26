import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';
import 'registration_page.dart';

class ProfileDisplayPage extends StatelessWidget {
  const ProfileDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context).student;

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
            const Text(
              'Profile Display',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: student.profileImage != null
                    ? FileImage(student.profileImage!)
                    : null,
                child: student.profileImage == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            _infoRow('Name:', student.name ?? ''),
            _infoRow('Email:', student.email ?? ''),
            _infoRow('Contact:', student.contact ?? ''),
            _infoRow('Date of Birth:', student.dob ?? ''),
            _infoRow('Gender:', student.gender ?? ''),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const StudentRegistrationPage(isEditing: true),
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
              Provider.of<StudentProvider>(context, listen: false)
                  .clearStudent();
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
