import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/features/onboarding/presentation/views_model/cubit/onboarding_cubit.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_constants.dart';

/// \"Skip\" pill button placed at the top-right of the onboarding screen.
///
/// Hidden (zero opacity + ignore pointer) on the last page because
/// \"Skip\" makes no sense when \"Get Started\" is already shown.
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
        child: GestureDetector(
          onTap: () => context.read<OnboardingCubit>().skipAll(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: Text(
              'تخطّى',
              style: TextStyle(
                fontSize: OnboardingConstants.skipButtonFontSize,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.80),
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
