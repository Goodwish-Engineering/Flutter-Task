import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map userData = {};
  bool _isEditing = false;

  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _dobController = TextEditingController();
  String? _gender;
  String _imagePath = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userData = ModalRoute.of(context)?.settings.arguments as Map;
    _nameController.text = userData['name'];
    _contactController.text = userData['contact'];
    _dobController.text = userData['dob'];
    _gender = userData['gender'];
    _imagePath = userData['profileImagePath'];
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', _nameController.text);
    await prefs.setString('user_contact', _contactController.text);
    await prefs.setString('user_dob', _dobController.text);
    await prefs.setString('user_gender', _gender ?? '');

    setState(() => _isEditing = false);
  }

  void _logout() => Navigator.pushReplacementNamed(context, '/');

  Future<void> _deleteAllData() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete all your data? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all saved data
      Navigator.pushReplacementNamed(context, '/register');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete all data',
            onPressed: _deleteAllData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: _imagePath.isNotEmpty ? FileImage(File(_imagePath)) : null,
              child: _imagePath.isEmpty ? const Icon(Icons.person, size: 60) : null,
            ),
            const SizedBox(height: 20),
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name'), enabled: _isEditing),
            TextField(controller: _contactController, decoration: const InputDecoration(labelText: 'Contact'), enabled: _isEditing),
            TextField(controller: _dobController, decoration: const InputDecoration(labelText: 'DOB'), enabled: _isEditing),
            DropdownButtonFormField<String>(
              value: _gender,
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: _isEditing ? (val) => setState(() => _gender = val) : null,
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const SizedBox(height: 20),
            if (_isEditing)
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _save, child: const Text('Save')))
            else
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => setState(() => _isEditing = true), child: const Text('Edit'))),
          ],
        ),
      ),
    );
  }
}
