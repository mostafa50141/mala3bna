import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/onboarding/presentation/views_model/cubit/onboarding_cubit.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_constants.dart';

/// "Skip" text button placed at the top-right of the onboarding screen.
///
/// Hidden (zero opacity + ignore pointer) on the last page because
/// "Skip" makes no sense when "Get Started" is already shown.
class OnboardingSkipButton extends StatelessWidget {
  final bool isLastPage;

  const OnboardingSkipButton({super.key, required this.isLastPage});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: OnboardingConstants.buttonAnimDuration,
      opacity: isLastPage ? 0.0 : 1.0,
      child: IgnorePointer(
        ignoring: isLastPage,
        child: TextButton(
          onPressed: () => context.read<OnboardingCubit>().skipAll(),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white70,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'تخطّى',
            style: TextStyle(
              fontSize: OnboardingConstants.skipButtonFontSize,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
