import '../../shared/models/user_model.dart';

abstract class AuthRepository {
  Future<void> sendOTP(String phoneNumber);
  Future<User> verifyOTP(String otp);
  Future<User> getCurrentUser();
  Future<void> updateProfile({String? name, String? email, String? profilePhotoUrl});
  Future<void> signOut();
  Stream<User?> get userStream;
}