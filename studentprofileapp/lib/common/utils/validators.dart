abstract class AppValidator {
// email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email address cannot be empty.";
    }
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Email validation failed: Invalid format.";
    }
    return null;
  }

// name validation
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Full Name cannot be empty.";
    }

    return null;
  }

// Number validation
static String? validateNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Contact number cannot be empty.';
  }

  String cleanedValue = value.replaceAll(' ', '');

  if (cleanedValue.length != 10) {
    return 'Contact number must be exactly 10 digits long.';
  }


  if (!RegExp(r'^[0-9]+$').hasMatch(cleanedValue)) {
    return 'Contact number can only contain digits.';
  }

  return null; 
}
}
