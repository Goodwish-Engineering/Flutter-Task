class Student {
  String fullname;
  String email;
  String contactNumber;
  DateTime dateOfBirth;
  String gender;
  String? profilePicturePath;

  Student({
    required this.fullname,
    required this.email,
    required this.contactNumber,
    required this.dateOfBirth,
    required this.gender,
    this.profilePicturePath,
  });

  Student copyWith({
    String? fullname,
    String? email,
    String? contactNumber,
    DateTime? dateOfBirth,
    String? gender,
    String? profilePicturePath,
  }) {
    return Student(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
    );
  }
}
