import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:grocify/shared/models/user_model.dart';
import 'package:grocify/features/auth/domain/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(firebase_auth.FirebaseAuthException e) onVerificationFailed,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (firebase_auth.PhoneAuthCredential credential) async {
        // Auto-verification on Android
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: onVerificationFailed,
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Future<User> verifyOTP({
    required String verificationId,
    required String otp,
  }) async {
    final credential = firebase_auth.PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final firebaseUser = userCredential.user;

    if (firebaseUser == null) {
      throw Exception('Failed to sign in');
    }

    return await getCurrentUser();
  }

  @override
  Future<User> getCurrentUser() async {
    final firebase_auth.User? firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw Exception('No user logged in');
    }

    final userDoc = await _firestore.collection('users').doc(firebaseUser.uid).get();
    if (!userDoc.exists) {
      final newUser = User(
        id: firebaseUser.uid,
        phoneNumber: firebaseUser.phoneNumber ?? '',
        addresses: [],
        isPhoneVerified: firebaseUser.phoneNumber != null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(firebaseUser.uid).set(newUser.toJson());
      return newUser;
    }

    return User.fromJson(userDoc.data()!);
  }

  @override
  Future<void> updateProfile({
    String? name,
    String? email,
    String? profilePhotoUrl,
  }) async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw Exception('No user logged in');
    }

    final updates = <String, dynamic>{
      'updatedAt': DateTime.now().toIso8601String(),
    };

    if (name != null) updates['name'] = name;
    if (email != null) updates['email'] = email;
    if (profilePhotoUrl != null) updates['profilePhotoUrl'] = profilePhotoUrl;

    await _firestore.collection('users').doc(firebaseUser.uid).update(updates);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<User?> get userStream {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;

      try {
        return await getCurrentUser();
      } catch (e) {
        return null;
      }
    });
  }
}