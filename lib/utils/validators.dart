class CountryCode {
  final String name;
  final String code;
  final String dialCode;
  final String placeholder;
  final int minLength;
  final int maxLength;

  const CountryCode({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.placeholder,
    required this.minLength,
    required this.maxLength,
  });
}

class Validators {
  static const List<CountryCode> countryCodes = [
    CountryCode(
      name: 'Nepal',
      code: 'NP',
      dialCode: '+977',
      placeholder: '98 1234 5678',
      minLength: 10,
      maxLength: 10,
    ),
    CountryCode(
      name: 'United States',
      code: 'US',
      dialCode: '+1',
      placeholder: '(555) 123-4567',
      minLength: 10,
      maxLength: 10,
    ),
    CountryCode(
      name: 'United Kingdom',
      code: 'GB',
      dialCode: '+44',
      placeholder: '7400 123456',
      minLength: 10,
      maxLength: 11,
    ),
    CountryCode(
      name: 'Canada',
      code: 'CA',
      dialCode: '+1',
      placeholder: '(555) 123-4567',
      minLength: 10,
      maxLength: 10,
    ),
    CountryCode(
      name: 'Australia',
      code: 'AU',
      dialCode: '+61',
      placeholder: '412 345 678',
      minLength: 9,
      maxLength: 9,
    ),
    CountryCode(
      name: 'Germany',
      code: 'DE',
      dialCode: '+49',
      placeholder: '151 12345678',
      minLength: 10,
      maxLength: 12,
    ),
    CountryCode(
      name: 'France',
      code: 'FR',
      dialCode: '+33',
      placeholder: '6 12 34 56 78',
      minLength: 9,
      maxLength: 9,
    ),
    CountryCode(
      name: 'India',
      code: 'IN',
      dialCode: '+91',
      placeholder: '98765 43210',
      minLength: 10,
      maxLength: 10,
    ),
    CountryCode(
      name: 'Japan',
      code: 'JP',
      dialCode: '+81',
      placeholder: '90 1234 5678',
      minLength: 10,
      maxLength: 11,
    ),
    CountryCode(
      name: 'South Korea',
      code: 'KR',
      dialCode: '+82',
      placeholder: '10 1234 5678',
      minLength: 9,
      maxLength: 10,
    ),
    CountryCode(
      name: 'Brazil',
      code: 'BR',
      dialCode: '+55',
      placeholder: '11 99999 9999',
      minLength: 10,
      maxLength: 11,
    ),
    CountryCode(
      name: 'Mexico',
      code: 'MX',
      dialCode: '+52',
      placeholder: '55 1234 5678',
      minLength: 10,
      maxLength: 10,
    ),
    CountryCode(
      name: 'China',
      code: 'CN',
      dialCode: '+86',
      placeholder: '138 0013 8000',
      minLength: 11,
      maxLength: 11,
    ),
  ];

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validateContactNumber(
    String? value,
    CountryCode? selectedCountry,
  ) {
    if (value == null || value.trim().isEmpty) {
      return 'Contact number is required';
    }

    if (selectedCountry == null) {
      return 'Please select a country code';
    }

    // Remove all non-digit characters for validation
    final cleanNumber = value.trim().replaceAll(RegExp(r'[^\d]'), '');

    if (cleanNumber.length < selectedCountry.minLength) {
      return 'Phone number must be at least ${selectedCountry.minLength} digits';
    }

    if (cleanNumber.length > selectedCountry.maxLength) {
      return 'Phone number cannot exceed ${selectedCountry.maxLength} digits';
    }

    // Basic number validation (starts with valid digit)
    if (cleanNumber.isEmpty || cleanNumber.startsWith('0')) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  static String formatPhoneNumber(String value, CountryCode countryCode) {
    final cleanNumber = value.replaceAll(RegExp(r'[^\d]'), '');

    switch (countryCode.code) {
      case 'NP':
        if (cleanNumber.length >= 4) {
          return cleanNumber.replaceAllMapped(
            RegExp(r'(\d{0,2})(\d{0,4})(\d{0,4})'),
            (match) {
              final group1 = match.group(1) ?? '';
              final group2 = match.group(2) ?? '';
              final group3 = match.group(3) ?? '';

              String formatted = group1;
              if (group2.isNotEmpty) formatted += ' $group2';
              if (group3.isNotEmpty) formatted += ' $group3';
              return formatted;
            },
          );
        }
        break;
      case 'US':
      case 'CA':
        if (cleanNumber.length >= 6) {
          if (cleanNumber.length <= 10) {
            return cleanNumber.replaceAllMapped(
              RegExp(r'(\d{0,3})(\d{0,3})(\d{0,4})'),
              (match) {
                String formatted = '';
                final group1 = match.group(1) ?? '';
                final group2 = match.group(2) ?? '';
                final group3 = match.group(3) ?? '';

                if (group1.isNotEmpty) formatted += '($group1';
                if (group1.length == 3) formatted += ') ';
                if (group2.isNotEmpty) formatted += group2;
                if (group2.length == 3) formatted += '-';
                if (group3.isNotEmpty) formatted += group3;
                return formatted;
              },
            );
          }
        }
        break;
      case 'GB':
        if (cleanNumber.length >= 4) {
          return cleanNumber.replaceAllMapped(RegExp(r'(\d{0,4})(\d{0,6})'), (
            match,
          ) {
            final group1 = match.group(1) ?? '';
            final group2 = match.group(2) ?? '';
            return '$group1 $group2'.trim();
          });
        }
        break;
      case 'IN':
        if (cleanNumber.length >= 5) {
          return cleanNumber.replaceAllMapped(RegExp(r'(\d{0,5})(\d{0,5})'), (
            match,
          ) {
            final group1 = match.group(1) ?? '';
            final group2 = match.group(2) ?? '';
            return '$group1 $group2'.trim();
          });
        }
        break;
      default:
        // Generic formatting for other countries
        if (cleanNumber.length >= 3) {
          return cleanNumber.replaceAllMapped(
            RegExp(r'(\d{2,3})(\d{0,4})(\d{0,4})'),
            (match) {
              final group1 = match.group(1) ?? '';
              final group2 = match.group(2) ?? '';
              final group3 = match.group(3) ?? '';

              String formatted = group1;
              if (group2.isNotEmpty) formatted += ' $group2';
              if (group3.isNotEmpty) formatted += ' $group3';
              return formatted;
            },
          );
        }
        break;
    }

    return cleanNumber;
  }

  static String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a gender';
    }
    return null;
  }

  static String? validateDateOfBirth(DateTime? value) {
    if (value == null) {
      return 'Date of birth is required';
    }
    final now = DateTime.now();
    final minAge = now.subtract(
      const Duration(days: 365 * 5),
    ); // Minimum 5 years old
    final maxAge = now.subtract(
      const Duration(days: 365 * 100),
    ); // Maximum 100 years old

    if (value.isAfter(minAge)) {
      return 'Age must be at least 5 years';
    }
    if (value.isBefore(maxAge)) {
      return 'Please enter a valid date of birth';
    }
    return null;
  }
}
