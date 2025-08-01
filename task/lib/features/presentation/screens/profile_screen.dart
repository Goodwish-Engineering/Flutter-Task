import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/models/hive/student.dart';
import 'package:task/core/utils/device_dimension.dart';
import 'package:task/core/utils/size_extension.dart';
import 'package:task/features/presentation/bloc/student_bloc.dart';
import 'package:task/features/presentation/screens/registration_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<StudentBloc>().add(LoadStudent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (!context.mounted) return;
    
          if (state is StudentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is StudentDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
    
            Future.microtask(() {
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                  (route) => false,
                );
              }
            });
          }
        },
        builder: (context, state) {
          if (state is StudentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is StudentLoaded) {
            final student = state.student;
            if (_isStudentEmpty(student)) {
              return _buildEmptyState(context);
            }
            return _buildProfileContent(context, student);
          } else if (state is StudentEmpty) {
            return _buildEmptyState(context);
          } else if (state is StudentError) {
            return _buildErrorState(context, state);
          }
          return _buildEmptyState(context);
        },
      ),
    );
  }

  bool _isStudentEmpty(Student student) {
    return (student.fullName == null || student.fullName!.isEmpty) &&
        (student.email == null || student.email!.isEmpty) &&
        (student.contactNumber == null || student.contactNumber!.isEmpty) &&
        (student.dateOfBirth == null || student.dateOfBirth!.isEmpty) &&
        (student.gender == null || student.gender!.isEmpty);
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No student profile found',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<StudentBloc>().add(LoadStudent());
            },
            child: const Text('Refresh'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const RegistrationScreen(),
                ),
                (route) => false,
              );
            },
            child: const Text('Create New Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, StudentError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            state.message,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<StudentBloc>().add(LoadStudent());
            },
            child: const Text('Retry'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              context.read<StudentBloc>().add(DeleteStudent());
            },
            child: const Text('Clear Data and Start Over'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, Student student) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.horizontalPadding, vertical: context.verticalPadding),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildProfileImage(student,context),
            const SizedBox(height: 20),
            _buildProfileItem('Full Name', student.fullName),
            _buildProfileItem('Email', student.email),
            _buildProfileItem('Contact Number', student.contactNumber),
            _buildProfileItem('Date of Birth', student.dateOfBirth),
            _buildProfileItem('Gender', student.gender),
            const SizedBox(height: 30),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(Student student, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          
          child: SizedBox(
            width: double.infinity,
            height: context.screenHeight*0.3,
            child: student.profilePicturePath != null
                ? Image.file(
                    File(student.profilePicturePath!),
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.person, size: 60),
                  ),
          ),
        ),
        if (student.profilePicturePath == null)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value ?? 'Not provided',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 16),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 400) {
          return Column(
            children: [
              _buildEditButton(context),
              const SizedBox(height: 12),
              _buildDeleteButton(context),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_buildEditButton(context), _buildDeleteButton(context)],
          );
        }
      },
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.edit, size: 20),
        label: const Text('Edit'),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        return SizedBox(
          width: 150,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.delete, size: 20),
            label: const Text('Delete'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: state is StudentLoading
                ? null
                : () => _showDeleteConfirmationDialog(context),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    if (!context.mounted) return;

    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text(
              'Are you sure you want to delete your profile? This cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    ).then((confirmed) {
      if (confirmed == true && context.mounted) {
        context.read<StudentBloc>().add(DeleteStudent());
      }
    });
  }
}
