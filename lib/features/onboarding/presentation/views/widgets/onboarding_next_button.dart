import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/onboarding/presentation/views_model/cubit/onboarding_cubit.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_constants.dart';

/// Primary CTA button.
///
/// Switches between "التالي" (Next) and "ابدأ الآن" (Get Started) using
/// [AnimatedSwitcher] for a smooth crossfade, so the user always knows
/// exactly where they are in the flow.
class OnboardingNextButton extends StatelessWidget {
  final bool isLastPage;

  const OnboardingNextButton({super.key, required this.isLastPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: OnboardingConstants.nextButtonHeight,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.primaryColor.withValues(alpha: 0.75),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius:
              BorderRadius.circular(OnboardingConstants.nextButtonRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context.read<OnboardingCubit>().nextPage(),
            borderRadius:
                BorderRadius.circular(OnboardingConstants.nextButtonRadius),
            child: Center(
              child: AnimatedSwitcher(
                duration: OnboardingConstants.buttonAnimDuration,
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: Text(
                  isLastPage ? 'ابدأ الآن' : 'التالي',
                  // Key is required so AnimatedSwitcher detects the widget swap.
                  key: ValueKey<bool>(isLastPage),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
