import 'package:flutter/material.dart';
import 'package:app/config/app_palette.dart';
import 'package:intl/intl.dart';

class DobPickerField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(DateTime date) onDateSelected;

  const DobPickerField({
    super.key,
    required this.controller,
    required this.onDateSelected,
  });

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.text = DateFormat('dd MMM yyyy').format(picked);
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(context),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        labelText: 'DOB',
        hintText: 'Select date',
        suffixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppPallete.borderColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppPallete.borderColor, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select date';
        }
        return null;
      },
    );
  }
}
