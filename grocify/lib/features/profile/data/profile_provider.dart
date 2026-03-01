import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/user_model.dart';

class ProfileState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const ProfileState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(const ProfileState()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock user data
      final mockUser = UserModel(
        id: 'user1',
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+94 77 123 4567',
        profileImageUrl: null,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        isEmailVerified: true,
        isPhoneVerified: true,
      );

      state = state.copyWith(user: mockUser, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load profile. Please try again.',
      );
    }
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Implement profile update
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(user: updatedUser, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to update profile. Please try again.',
      );
    }
  }

  Future<void> signOut() async {
    try {
      // TODO: Implement sign out
      state = const ProfileState();
    } catch (e) {
      state = state.copyWith(error: 'Failed to sign out');
    }
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});