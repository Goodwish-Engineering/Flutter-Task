import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
final controller;
final String? hint;
final FormFieldValidator<String>? validator;
final TextInputType? keyboardType;
final Function? onTap;

   MyTextField({
    super.key,
    required this.controller,
    this.hint,
    this.validator,
    this.keyboardType,
    this.onTap,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextFormField(
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          onTap: widget.onTap as void Function()?,
          validator: widget.validator,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          cursorColor: Colors.white,
          controller: widget.controller as TextEditingController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 8, 80, 128)),
            ),
            fillColor: Colors.transparent,
            filled: true,
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            errorStyle: TextStyle(
              color: const Color.fromARGB(255, 162, 11, 0),
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}