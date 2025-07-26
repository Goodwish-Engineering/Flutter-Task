import 'package:app/config/app_palette.dart';
import 'package:app/model/gender_type_enum.dart';
import 'package:flutter/material.dart';

// extension GenderExtension on Gender {
//   String get displayName {
//     switch (this) {
//       case Gender.MALE:
//         return 'Male';
//       case Gender.FEMALE:
//         return 'Female';
//       case Gender.OTHERS:
//         return 'Other';
//     }
//   }
// }

class GenderDropdownField extends StatelessWidget {
  final Gender? value;
  final void Function(Gender?) onChanged;

  const GenderDropdownField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender>(
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        labelText: 'Gender',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppPallete.borderColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppPallete.borderColor, width: 2),
        ),
      ),
      items:
          Gender.values.map((gender) {
            return DropdownMenuItem<Gender>(
              value: gender,
              child: Text(gender.displayName),
            );
          }).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender';
        }
        return null;
      },
    );
  }
}
