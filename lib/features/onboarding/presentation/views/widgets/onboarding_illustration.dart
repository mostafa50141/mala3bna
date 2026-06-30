import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mala3bna/features/onboarding/data/models/onboarding_page_model.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_constants.dart';

/// Renders the Lottie animation for a single onboarding page.
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
    // Play once on the last page so "success" feels deliberate.
    final isLastPage = pageIndex == OnboardingConstants.pageCount - 1;

    return SizedBox(
      height: screenHeight * OnboardingConstants.lottieHeightFraction,
      child: Lottie.asset(
        page.lottieAsset,
        repeat: !isLastPage,
        fit: BoxFit.contain,
        // Gracefully fall back to an icon if the Lottie file fails to load.
        errorBuilder: (_, __, ___) => Icon(
          Icons.sports_soccer_rounded,
          size: 120,
          color: page.accentColor,
        ),
      ),
    );
  }
}
