import 'package:flutter_test/flutter_test.dart';
import 'package:paceflow/core/constants/app_constants.dart';
import 'package:paceflow/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('returns error for null or empty', () {
      expect(Validators.email(null), isNotNull);
      expect(Validators.email(''), isNotNull);
      expect(Validators.email('   '), isNotNull);
    });

    test('returns error for invalid format', () {
      expect(Validators.email('not-an-email'), isNotNull);
      expect(Validators.email('missing@domain'), isNotNull);
    });

    test('returns null for valid email', () {
      expect(Validators.email('user@example.com'), isNull);
      expect(Validators.email('  user.name+tag@example.co.uk  '), isNull);
    });
  });

  group('Validators.password', () {
    test('returns error when too short', () {
      expect(Validators.password('Ab1'), isNotNull);
    });

    test('returns error when missing letter or number', () {
      expect(Validators.password('12345678'), isNotNull);
      expect(Validators.password('abcdefgh'), isNotNull);
    });

    test('returns null for valid password', () {
      expect(Validators.password('SecurePass1'), isNull);
    });

    test('returns error when exceeding max length', () {
      final long = 'A1${'x' * AppConstants.passwordMaxLength}';
      expect(Validators.password(long), isNotNull);
    });
  });

  group('Validators.passwordRequired', () {
    test('only checks presence', () {
      expect(Validators.passwordRequired(null), isNotNull);
      expect(Validators.passwordRequired('any'), isNull);
    });
  });

  group('Validators.confirmPassword', () {
    test('returns error when passwords mismatch', () {
      expect(Validators.confirmPassword('abc', 'def'), isNotNull);
    });

    test('returns null when passwords match', () {
      expect(Validators.confirmPassword('SecurePass1', 'SecurePass1'), isNull);
    });
  });

  group('Validators.displayName', () {
    test('returns error for too short name', () {
      expect(Validators.displayName('A'), isNotNull);
    });

    test('returns error for invalid characters', () {
      expect(Validators.displayName('User<script>'), isNotNull);
    });

    test('returns null for valid display name', () {
      expect(Validators.displayName('Alex Walker'), isNull);
      expect(Validators.displayName("O'Brien"), isNull);
    });
  });

  group('Validators.bio', () {
    test('allows empty bio', () {
      expect(Validators.bio(null), isNull);
      expect(Validators.bio(''), isNull);
    });

    test('returns error when too long', () {
      final longBio = 'x' * (AppConstants.bioMaxLength + 1);
      expect(Validators.bio(longBio), isNotNull);
    });
  });

  group('Validators.weightKg', () {
    test('allows empty weight', () {
      expect(Validators.weightKg(null), isNull);
      expect(Validators.weightKg(''), isNull);
    });

    test('returns error for non-numeric or out of range', () {
      expect(Validators.weightKg('abc'), isNotNull);
      expect(Validators.weightKg('10'), isNotNull);
      expect(Validators.weightKg('350'), isNotNull);
    });

    test('returns null for valid weight', () {
      expect(Validators.weightKg('70'), isNull);
      expect(Validators.weightKg(' 72.5 '), isNull);
    });
  });
}
