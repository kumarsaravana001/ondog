class ValidationUtil {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First Name is required';
    }

    RegExp specialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (specialCharacters.hasMatch(value)) {
      return 'No special characters allowed';
    }

    return null;
  }
}
