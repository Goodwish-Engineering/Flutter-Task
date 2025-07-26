import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final String placeholder;
  final TextEditingController controller;
  final bool isEmail;
  final bool isNumber;

  const AuthField({
    super.key,
    this.hintText = "",
    required this.placeholder,
    required this.controller,
    this.isEmail = false,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(hintText: hintText, labelText: placeholder),
      keyboardType:
          isEmail
              ? TextInputType.emailAddress
              : isNumber
              ? TextInputType.number
              : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }

        if (placeholder.toLowerCase().contains('email')) {
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        }

        if (placeholder.toLowerCase().contains('contact')) {
          if (value.length < 10) {
            return 'Number should be 10 digits';
          }
          final phoneRegex = RegExp(r'^[+]?[0-9]{10,15}$');
          if (!phoneRegex.hasMatch(value.replaceAll(' ', ''))) {
            return 'Please enter a valid contact number';
          }
        }

        if (placeholder.toLowerCase().contains('name')) {
          if (value.length < 2) {
            return 'Name must be at least 2 characters long';
          }
          final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
          if (!nameRegex.hasMatch(value)) {
            return 'Name can only contain letters and spaces';
          }
        }

        return null;
      },
    );
  }
}
