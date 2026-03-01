import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final bool hasSeenOnboarding;

  const OnboardingState({required this.hasSeenOnboarding});

  OnboardingState copyWith({bool? hasSeenOnboarding}) {
    return OnboardingState(
      hasSeenOnboarding: hasSeenOnboarding ?? this.hasSeenOnboarding,
    );
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(const OnboardingState(hasSeenOnboarding: false)) {
    _loadOnboardingStatus();
  }

  Future<void> _loadOnboardingStatus() async {
    // TODO: Load from shared preferences
    // For now, assume not seen
    state = const OnboardingState(hasSeenOnboarding: false);
  }

  Future<void> markOnboardingComplete() async {
    // TODO: Save to shared preferences
    state = state.copyWith(hasSeenOnboarding: true);
  }
}

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>(
  (ref) => OnboardingNotifier(),
);