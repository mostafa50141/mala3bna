import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mala3bna/features/onboarding/data/models/onboarding_page_model.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_constants.dart';

/// Renders the Lottie animation for a single onboarding page with
/// a soft accent-colour glow halo behind it.
///
/// Page 2 (index 2, "Get Started") plays once to completion for a
/// satisfying finale; all other pages loop continuously.
class OnboardingIllustration extends StatelessWidget {
  final OnboardingPageModel page;
  final int pageIndex;

  const OnboardingIllustration({
    super.key,
    required this.page,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isLastPage = pageIndex == OnboardingConstants.pageCount - 1;
    final lottieHeight = screenHeight * OnboardingConstants.lottieHeightFraction;

    return SizedBox(
      height: lottieHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // â”€â”€ Accent glow halo â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Container(
            width: lottieHeight * 0.65,
            height: lottieHeight * 0.65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  page.accentColor.withValues(alpha: 0.22),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // â”€â”€ Lottie animation â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Lottie.asset(
            page.lottieAsset,
            height: lottieHeight,
            repeat: !isLastPage,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              Icons.sports_soccer_rounded,
              size: 120,
              color: page.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
