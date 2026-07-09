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
  final Color accentColor;

  const OnboardingPageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
    this.accentColor = AppColors.primaryColor,
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
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.symmetric(
        horizontal: OnboardingConstants.dotSpacing / 2,
      ),
      width: isActive
          ? OnboardingConstants.dotActivWidth
          : OnboardingConstants.dotInactiveWidth,
      height: OnboardingConstants.dotHeight,
      decoration: BoxDecoration(
        color: isActive
            ? accentColor
            : accentColor.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(OnboardingConstants.dotBorderRadius),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.45),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
    );
  }
}
