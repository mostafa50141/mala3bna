part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

/// Fired on the first render — [currentPage] is always 0.
final class OnboardingInitial extends OnboardingState {
  final int currentPage = 0;
  final bool isLastPage = false;
}

/// Emitted every time the visible page changes.
final class OnboardingPageChanged extends OnboardingState {
  final int currentPage;
  final bool isLastPage;

  OnboardingPageChanged({
    required this.currentPage,
    required this.isLastPage,
  });
}

/// Emitted after onboarding is persisted — UI navigates away.
final class OnboardingCompleted extends OnboardingState {}
