import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../shared/models/user_model.dart';
import 'auth_repository_impl.dart';

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final String? verificationId;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.verificationId,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    String? verificationId,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      verificationId: verificationId ?? this.verificationId,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepositoryImpl _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState()) {
    _init();
  }

  void _init() {
    _authRepository.userStream.listen((user) {
      state = state.copyWith(user: user, isLoading: false);
    });
  }

  Future<void> sendOTP(String phoneNumber) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.sendOTP(
        phoneNumber: phoneNumber,
        onCodeSent: (verificationId) {
          state = state.copyWith(isLoading: false, verificationId: verificationId);
        },
        onVerificationFailed: (e) {
          state = state.copyWith(isLoading: false, error: e.message);
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> verifyOTP(String otp) async {
    if (state.verificationId == null) {
      throw Exception('No verification ID available');
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _authRepository.verifyOTP(
        verificationId: state.verificationId!,
        otp: otp,
      );
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? profilePhotoUrl,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.updateProfile(
        name: name,
        email: email,
        profilePhotoUrl: profilePhotoUrl,
      );

      final updatedUser = await _authRepository.getCurrentUser();
      state = state.copyWith(user: updatedUser, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _authRepository.signOut();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(AuthRepositoryImpl()),
);