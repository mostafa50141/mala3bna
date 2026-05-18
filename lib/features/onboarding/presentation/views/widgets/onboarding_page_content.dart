import 'package:flutter/material.dart';
import 'package:mala3bna/features/onboarding/data/models/onboarding_page_model.dart';
import 'package:mala3bna/features/onboarding/presentation/views/widgets/onboarding_constants.dart';

/// Renders the title and description for one onboarding page with
/// staggered slide-up + fade-in animations.
///
/// Receives pre-built [titleOpacity], [titleSlide], [descOpacity],
/// [descSlide] animations from [OnboardingPageView] which owns the
/// [AnimationController] and resets/plays it on every page transition.
class OnboardingPageContent extends StatelessWidget {
  final OnboardingPageModel page;
  final Animation<double> titleOpacity;
  final Animation<Offset> titleSlide;
  final Animation<double> descOpacity;
  final Animation<Offset> descSlide;

  const OnboardingPageContent({
    super.key,
    required this.page,
    required this.titleOpacity,
    required this.titleSlide,
    required this.descOpacity,
    required this.descSlide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: OnboardingConstants.contentHorizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Animated title ───────────────────────────────────────────────
          FadeTransition(
            opacity: titleOpacity,
            child: SlideTransition(
              position: titleSlide,
              child: Text(
                page.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: OnboardingConstants.titleFontSize,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: OnboardingConstants.titleLetterSpacing,
                  height: 1.2,
                ),
              ),
            ),
          ),

          const SizedBox(height: OnboardingConstants.spacingTitleToDesc),

          // ── Animated description ─────────────────────────────────────────
          FadeTransition(
            opacity: descOpacity,
            child: SlideTransition(
              position: descSlide,
              child: Text(
                page.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: OnboardingConstants.descFontSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.white60,
                  height: OnboardingConstants.descLineHeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
