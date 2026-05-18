part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

/// Initial idle state — animations have not finished yet.
final class SplashInitial extends SplashState {}

/// Intermediate state while the async navigation check is running.
final class SplashNavigating extends SplashState {}

/// Emitted when a valid token is found → route to [AppRoot].
final class SplashNavigateToHome extends SplashState {}

/// Emitted when no token is found and onboarding hasn't been seen → route to [OnboardingScreen].
final class SplashNavigateToOnboarding extends SplashState {}

/// Emitted when no token is found but onboarding has been seen → route to [WelcomeScreen].
final class SplashNavigateToWelcome extends SplashState {}
