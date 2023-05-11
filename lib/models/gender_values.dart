enum Gender {
  male,
  female,
  na,
}

extension GenderExtension on Gender {
  String get name {
    switch (this) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
      case Gender.na:
        return "n/a";
      default:
        return "";
    }
  }
}
