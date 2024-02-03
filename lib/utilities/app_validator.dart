class ValidationUtil {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      // Check if the input is null or empty
      return 'First Name is required';
    }

    if (value.length > 9) {
      // Check if the input exceeds 9 characters
      return 'Name must not exceed 9 characters';
    }

    RegExp onlyAlphabets = RegExp(r'^[a-zA-Z]+$');
    if (!onlyAlphabets.hasMatch(value)) {
      // Check if the input contains only alphabets
      return 'Name must contain only alphabets';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Basic structure check
    if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)) {
      return 'Enter a valid Email';
    }

    // Additional checks for common requirements
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      return 'Invalid email format';
    }

    // Length check - ensuring the email is not too long
    if (value.length > 254) {
      return 'Email is too long';
    }

    // Local part length check (before the @ symbol)
    final localPart = value.split('@').first;
    if (localPart.length > 64) {
      return 'Email local part (before the @) is too long';
    }

    // Domain part length check (after the @ symbol)
    final domainPart = value.split('@').last;
    if (domainPart.length > 255) {
      return 'Email domain part (after the @) is too long';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    // Check for at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must have at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must have at least one lowercase letter';
    }

    // Check for at least one number
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must have at least one number';
    }

    // Check for at least one special character
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must have at least one special character';
    }

    // Optional: Check for disallowed consecutive characters or patterns
    // Example: Avoid three consecutive identical characters
    if (RegExp(r'(.)\1\1').hasMatch(value)) {
      return 'Password cannot have three identical characters in a row';
    }

    return null; // If all checks pass, return null
  }
}
