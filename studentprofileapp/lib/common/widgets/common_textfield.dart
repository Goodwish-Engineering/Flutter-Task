import 'package:flutter/material.dart';

// textfield
class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.validator,
    

    required this.onChanged,
    this.keyboardType = TextInputType.text,
  });
  final String labelText;
  
  final TextEditingController controller;
  final FormFieldValidator<String>? validator; // added this

  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      
      keyboardType: keyboardType,
      onChanged: onChanged,
      cursorColor: theme.cardColor,
      style: TextStyle(fontSize: 16),
      validator: validator,
      controller: controller,

      obscuringCharacter: '•',

      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: theme.textTheme.bodySmall,
      ),
    );
  }
}
