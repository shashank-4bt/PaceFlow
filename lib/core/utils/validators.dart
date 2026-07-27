import '../constants/app_constants.dart';

/// Input validation helpers for forms and domain rules.
abstract final class Validators {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }
    final trimmed = value.trim();
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(trimmed)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < AppConstants.passwordMinLength) {
      return 'Password must be at least ${AppConstants.passwordMinLength} characters.';
    }
    if (value.length > AppConstants.passwordMaxLength) {
      return 'Password must be at most ${AppConstants.passwordMaxLength} characters.';
    }
    if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      return 'Password must contain at least one letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number.';
    }
    return null;
  }

  /// Sign-in only: checks presence without enforcing creation rules.
  static String? passwordRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }
    if (value != password) {
      return 'Passwords do not match.';
    }
    return null;
  }

  static String? displayName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Display name is required.';
    }
    final trimmed = value.trim();
    if (trimmed.length < AppConstants.displayNameMinLength) {
      return 'Display name must be at least ${AppConstants.displayNameMinLength} characters.';
    }
    if (trimmed.length > AppConstants.displayNameMaxLength) {
      return 'Display name must be at most ${AppConstants.displayNameMaxLength} characters.';
    }
    if (!RegExp(r"^[\p{L}\p{N}\s\-_.']+$", unicode: true).hasMatch(trimmed)) {
      return 'Display name contains invalid characters.';
    }
    return null;
  }

  static String? bio(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length > AppConstants.bioMaxLength) {
      return 'Bio must be at most ${AppConstants.bioMaxLength} characters.';
    }
    return null;
  }

  static String? weightKg(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parsed = double.tryParse(value.trim());
    if (parsed == null) {
      return 'Enter a valid weight.';
    }
    if (parsed < 20 || parsed > 300) {
      return 'Weight must be between 20 and 300 kg.';
    }
    return null;
  }
}
