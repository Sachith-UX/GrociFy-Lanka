import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:grocify/shared/models/user_model.dart';

abstract class AuthRepository {
  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(firebase_auth.FirebaseAuthException e) onVerificationFailed,
  });

  Future<User> verifyOTP({
    required String verificationId,
    required String otp,
  });

  Future<User> getCurrentUser();
  Future<void> updateProfile({String? name, String? email, String? profilePhotoUrl});
  Future<void> signOut();
  Stream<User?> get userStream;
}