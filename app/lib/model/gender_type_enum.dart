enum Gender { MALE, FEMALE, OTHERS }

extension GenderExtension on Gender {
  String get displayName {
    switch (this) {
      case Gender.MALE:
        return 'Male';
      case Gender.FEMALE:
        return 'Female';
      case Gender.OTHERS:
        return 'Other';
    }
  }
}
