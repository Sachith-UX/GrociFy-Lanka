import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../shared/models/user_model.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> sendOTP(String phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-verification on Android
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        throw Exception('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Store verificationId for later use
        // This would be handled by the provider
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
      },
    );
  }

  @override
  Future<User> verifyOTP(String otp) async {
    // This would need the verificationId from sendOTP
    // For simplicity, assuming it's handled by the provider
    throw UnimplementedError('verifyOTP needs verificationId from sendOTP');
  }

  @override
  Future<User> getCurrentUser() async {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) {
      throw Exception('No user logged in');
    }

    final userDoc = await _firestore.collection('users').doc(firebaseUser.uid).get();
    if (!userDoc.exists) {
      // Create new user document
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