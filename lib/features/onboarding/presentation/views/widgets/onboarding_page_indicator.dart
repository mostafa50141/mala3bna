import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_constants.dart';

/// Animated dot-strip page indicator.
///
/// The active dot expands to [OnboardingConstants.dotActivWidth] while
/// inactive dots shrink to [OnboardingConstants.dotInactiveWidth].
/// All transitions are driven by [AnimatedContainer] with a smooth curve.
class OnboardingPageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const OnboardingPageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageCount, _buildDot),
    );
  }

  Widget _buildDot(int index) {
    final isActive = index == currentPage;
    return AnimatedContainer(
      duration: OnboardingConstants.dotAnimDuration,
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(
        horizontal: OnboardingConstants.dotSpacing / 2,
      ),
      width: isActive
          ? OnboardingConstants.dotActivWidth
          : OnboardingConstants.dotInactiveWidth,
      height: OnboardingConstants.dotHeight,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primaryColor
            : AppColors.primaryColor.withValues(alpha: 0.30),
        borderRadius: BorderRadius.circular(OnboardingConstants.dotBorderRadius),
      ),
    );
  }
}
