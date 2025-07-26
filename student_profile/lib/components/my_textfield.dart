import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
final controller;
final String hint;
bool obscureText;
final String? errorText;
final FocusNode? focusNode;

   MyTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.errorText,
    this.focusNode,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _obscureText;

  @override
  void initState(){
    super.initState();
    _obscureText = widget.obscureText;
  }
  void toggleObscureText(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
      child: TextField(
        cursorColor: Colors.white,
        controller: widget.controller as TextEditingController,
        obscureText: _obscureText,
        focusNode: widget.focusNode,
        decoration: InputDecoration(
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: toggleObscureText,
                )
              : null,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlueAccent),
          ),
          fillColor: Colors.transparent,
          filled: true,
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.5),
          ),
          errorText: widget.errorText,
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 14,
          )
        ),
      ),

    );
  }
}