class Student {
  final String fullName;
  final String email;
  final String contactNumber;
  final String countryCode;
  final String dialCode;
  final DateTime dateOfBirth;
  final String gender;
  final String? profilePicturePath;

  Student({
    required this.fullName,
    required this.email,
    required this.contactNumber,
    required this.countryCode,
    required this.dialCode,
    required this.dateOfBirth,
    required this.gender,
    this.profilePicturePath,
  });

  String get fullPhoneNumber => '$dialCode $contactNumber';

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'contactNumber': contactNumber,
      'countryCode': countryCode,
      'dialCode': dialCode,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'profilePicturePath': profilePicturePath,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      countryCode: json['countryCode'] ?? 'US',
      dialCode: json['dialCode'] ?? '+1',
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'] ?? '',
      profilePicturePath: json['profilePicturePath'],
    );
  }

  Student copyWith({
    String? fullName,
    String? email,
    String? contactNumber,
    String? countryCode,
    String? dialCode,
    DateTime? dateOfBirth,
    String? gender,
    String? profilePicturePath,
  }) {
    return Student(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      countryCode: countryCode ?? this.countryCode,
      dialCode: dialCode ?? this.dialCode,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      profilePicturePath: profilePicturePath ?? this.profilePicturePath,
    );
  }
}
