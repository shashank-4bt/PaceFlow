import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/logging/app_logger.dart';
import '../../../../core/services/analytics_service.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../models/user_profile_model.dart';

/// Remote datasource for Firebase Auth, Google Sign-In, and Firestore profiles.
class AuthRemoteDataSource {
  AuthRemoteDataSource({
    required firebase_auth.FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required FirebaseStorage firebaseStorage,
    required GoogleSignIn googleSignIn,
    required SecureStorageService secureStorage,
    required AnalyticsService analyticsService,
  })  : _auth = firebaseAuth,
        _firestore = firestore,
        _storage = firebaseStorage,
        _googleSignIn = googleSignIn,
        _secureStorage = secureStorage,
        _analytics = analyticsService;

  final firebase_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final GoogleSignIn _googleSignIn;
  final SecureStorageService _secureStorage;
  final AnalyticsService _analytics;
  final AppLogger _logger = AppLogger('AuthRemoteDataSource');

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  Stream<UserProfileModel?> watchAuthState() {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) {
        return null;
      }
      try {
        return await _fetchUserProfile(user.uid);
      } catch (error, stackTrace) {
        _logger.warning(
          'Failed to fetch profile on auth state change',
          error,
          stackTrace,
        );
        return _profileFromAuthUser(user);
      }
    });
  }

  Future<UserProfileModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw const AuthException(message: 'Sign in failed. No user returned.');
      }
      await _persistTokens(user);
      final profile = await _fetchOrCreateProfile(user);
      await _analytics.logLogin(method: 'email');
      return profile;
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw AuthException(message: error.message ?? 'Sign in failed.', code: error.code, cause: error);
    }
  }

  Future<UserProfileModel> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user;
      if (user == null) {
        throw const AuthException(message: 'Sign up failed. No user returned.');
      }

      await user.updateDisplayName(displayName.trim());
      await user.reload();
      final refreshedUser = _auth.currentUser!;

      final profile = UserProfileModel(
        uid: refreshedUser.uid,
        email: refreshedUser.email ?? email.trim(),
        displayName: displayName.trim(),
        photoUrl: refreshedUser.photoURL,
        onboardingCompleted: false,
      );

      await _usersCollection
          .doc(refreshedUser.uid)
          .set(profile.toFirestore(isCreate: true));

      await _persistTokens(refreshedUser);
      await _analytics.logSignUp(method: 'email');
      return profile;
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw AuthException(message: error.message ?? 'Sign up failed.', code: error.code, cause: error);
    }
  }

  Future<UserProfileModel> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException(
          message: 'Google sign in was cancelled.',
          code: 'google_sign_in_cancelled',
        );
      }

      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) {
        throw const AuthException(message: 'Google sign in failed.');
      }

      await _persistTokens(user);
      final profile = await _fetchOrCreateProfile(
        user,
        fallbackDisplayName: googleUser.displayName,
        fallbackPhotoUrl: googleUser.photoUrl,
      );
      await _analytics.logLogin(method: 'google');
      return profile;
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw AuthException(
        message: error.message ?? 'Google sign in failed.',
        code: error.code,
        cause: error,
      );
    } catch (error) {
      if (error is AuthException) {
        rethrow;
      }
      throw AuthException(
        message: 'Google sign in failed.',
        cause: error,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
        _secureStorage.clearAuthTokens(),
      ]);
    } catch (error) {
      throw AuthException(message: 'Sign out failed.', cause: error);
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw AuthException(
        message: error.message ?? 'Failed to send reset email.',
        code: error.code,
        cause: error,
      );
    }
  }

  Future<UserProfileModel> updateProfile(UserProfileModel profile) async {
    try {
      final docRef = _usersCollection.doc(profile.uid);
      await docRef.set(profile.toFirestore(), SetOptions(merge: true));

      final currentUser = _auth.currentUser;
      if (currentUser != null && currentUser.uid == profile.uid) {
        if (currentUser.displayName != profile.displayName) {
          await currentUser.updateDisplayName(profile.displayName);
        }
        if (profile.photoUrl != null &&
            currentUser.photoURL != profile.photoUrl) {
          await currentUser.updatePhotoURL(profile.photoUrl);
        }
      }

      return await _fetchUserProfile(profile.uid);
    } catch (error) {
      throw ServerException(message: 'Failed to update profile.', cause: error);
    }
  }

  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AuthException(message: 'No signed-in user to delete.');
    }

    try {
      await _usersCollection.doc(user.uid).set(
        {
          'isDeleted': true,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      await _deleteUserStorage(user.uid);
      await user.delete();
      await _googleSignIn.signOut();
      await _secureStorage.clearAuthTokens();
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw AuthException(
        message: error.message ?? 'Failed to delete account.',
        code: error.code,
        cause: error,
      );
    } catch (error) {
      if (error is AuthException) {
        rethrow;
      }
      throw AuthException(message: 'Failed to delete account.', cause: error);
    }
  }

  Future<UserProfileModel> _fetchOrCreateProfile(
    firebase_auth.User user, {
    String? fallbackDisplayName,
    String? fallbackPhotoUrl,
  }) async {
    final existing = await _usersCollection.doc(user.uid).get();
    if (existing.exists) {
      final model = UserProfileModel.fromFirestore(existing);
      if (model.isDeleted) {
        await _usersCollection.doc(user.uid).set(
          {'isDeleted': false, 'updatedAt': FieldValue.serverTimestamp()},
          SetOptions(merge: true),
        );
      }
      return model;
    }

    final profile = UserProfileModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ??
          fallbackDisplayName ??
          user.email?.split('@').first ??
          'Walker',
      photoUrl: user.photoURL ?? fallbackPhotoUrl,
      onboardingCompleted: false,
    );

    await _usersCollection
        .doc(user.uid)
        .set(profile.toFirestore(isCreate: true));
    return profile;
  }

  Future<UserProfileModel> _fetchUserProfile(String uid) async {
    final snapshot = await _usersCollection.doc(uid).get();
    if (!snapshot.exists) {
      final user = _auth.currentUser;
      if (user != null && user.uid == uid) {
        return _profileFromAuthUser(user);
      }
      throw const ServerException(message: 'User profile not found.');
    }
    return UserProfileModel.fromFirestore(snapshot);
  }

  UserProfileModel _profileFromAuthUser(firebase_auth.User user) {
    return UserProfileModel(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ??
          user.email?.split('@').first ??
          AppConstants.appName,
      photoUrl: user.photoURL,
    );
  }

  Future<void> _persistTokens(firebase_auth.User user) async {
    final idToken = await user.getIdToken();
    if (idToken != null) {
      await _secureStorage.saveAuthTokens(idToken: idToken);
    }
  }

  Future<void> _deleteUserStorage(String uid) async {
    try {
      final avatarRef = _storage.ref().child('users/$uid/avatar');
      await avatarRef.delete().catchError((_) {});
      final shareRef = _storage.ref().child('users/$uid/shares');
      try {
        final listResult = await shareRef.listAll();
        for (final item in listResult.items) {
          await item.delete().catchError((_) {});
        }
      } catch (_) {
        // Share folder may not exist for all users.
      }
    } catch (error, stackTrace) {
      _logger.warning('Partial storage cleanup failure', error, stackTrace);
    }
  }
}
