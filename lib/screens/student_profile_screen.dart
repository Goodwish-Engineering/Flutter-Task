import 'package:flutter/material.dart';
import 'package:flutter_task/models/student_model.dart';
import 'package:flutter_task/provider/student_provider.dart';
import 'package:flutter_task/screens/student_registration_screen.dart';
import 'package:provider/provider.dart';

class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  /// Navigates to the registration screen.
  void _navigateToRegistration({bool editMode = false}) {
    // We use pushReplacement to avoid building up a stack of pages.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StudentRegistrationScreen(editMode: editMode),
      ),
    );
  }

  /// Shows a confirmation dialog before deleting the student data.
  Future<void> _confirmAndRemoveStudent(StudentProvider provider) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to remove this profile? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Delete'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      provider.clearStudent();
      // After clearing, navigate back to the registration screen.
      if (mounted) {
        _navigateToRegistration();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer here to listen for changes and get the provider instance.
    return Consumer<StudentProvider>(
      builder: (context, studentProvider, child) {
        final student = studentProvider.student;

        // If no student data exists, show a loading screen and redirect.
        if (student == null) {
          // Schedule the navigation to happen after the build is complete.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigateToRegistration();
          });
          // Show a loading indicator while redirecting.
          return Scaffold(
            appBar: AppBar(title: const Text('Student Profile')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // If student data exists, build the profile screen.
        return Scaffold(
          appBar: AppBar(
            title: const Text('Student Profile'),
          ),
          body: Center(
            child: ConstrainedBox(
              // For responsiveness on wider screens
              constraints: const BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildProfileHeader(student),
                      const SizedBox(height: 24),
                      _buildInfoCard(student),
                      const SizedBox(height: 24),
                      _buildActionButtons(studentProvider),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the top section with the profile picture and name.
  Widget _buildProfileHeader(Student student) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          backgroundImage: FileImage(student.profilePicture),
        ),
        const SizedBox(height: 16),
        Text(
          student.fullName,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          student.email,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }

  /// Builds the card containing the student's detailed information.
  Widget _buildInfoCard(Student student) {
    // Capitalize the first letter of the gender string for display.
    final genderString = student.gender.toString().split('.').last;
    final displayGender =
        genderString[0].toUpperCase() + genderString.substring(1);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            _buildInfoTile(
              icon: Icons.wc,
              label: 'Gender',
              value: displayGender,
            ),
            const Divider(indent: 16, endIndent: 16),
            _buildInfoTile(
              icon: Icons.phone_outlined,
              label: 'Contact Number',
              value: student.contactNumber,
            ),
            const Divider(indent: 16, endIndent: 16),
            _buildInfoTile(
              icon: Icons.calendar_today_outlined,
              label: 'Date of Birth',
              value: student.dob.toIso8601String().split('T').first,
            ),
          ],
        ),
      ),
    );
  }

  /// A reusable widget for displaying a piece of information with an icon.
  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(label, style: Theme.of(context).textTheme.bodySmall),
      subtitle: Text(
        value,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  /// Builds the Edit and Remove action buttons.
  Widget _buildActionButtons(StudentProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Edit Button (Outlined for secondary action)
        OutlinedButton.icon(
          icon: const Icon(Icons.edit_outlined),
          label: const Text('Edit Profile'),
          onPressed: () => _navigateToRegistration(editMode: true),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Remove Button (Filled for primary destructive action)
        FilledButton.icon(
          icon: const Icon(Icons.delete_outline),
          label: const Text('Remove'),
          onPressed: () => _confirmAndRemoveStudent(provider),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}