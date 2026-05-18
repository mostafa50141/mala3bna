import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/onboarding/data/models/onboarding_page_model.dart';

/// Central repository for all onboarding feature constants.
///
/// Covers layout dimensions, animation timings, typography values,
/// page content, and asset paths. No value should be hardcoded in
/// any widget or cubit file — reference this class instead.
class OnboardingConstants {
  OnboardingConstants._(); // prevent instantiation

  // ─── Page content ──────────────────────────────────────────────────────────
  static final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      title: 'اكتشف الملاعب',
      description:
          'ابحث عن ملاعب كرة القدم والبادل والرياضات المتعددة بالقرب منك\nبسهولة وفي أي وقت.',
      lottieAsset: 'assets/animations/Confirm.json',
      accentColor: AppColors.primaryColor,
    ),
    OnboardingPageModel(
      title: 'انضم للمباريات',
      description:
          'تصفح المباريات المفتوحة وانضم إلى الفريق المناسب لك.\nلا تفوّت أي مباراة بعد الآن.',
      lottieAsset: 'assets/animations/Football team players.json',
      accentColor: const Color(0xFF4CAF82),
    ),
    OnboardingPageModel(
      title: 'احجز بكل سهولة',
      description:
          'احجز ملعبك المفضل في ثوانٍ معدودة.\nوقتك لعبتك — أنت من يتحكم.',
      lottieAsset: 'assets/animations/Success.json',
      accentColor: const Color(0xFF2ECC9F),
    ),
  ];

  static int get pageCount => pages.length;

  // ─── Animation durations ───────────────────────────────────────────────────
  static const Duration contentAnimDuration = Duration(milliseconds: 380);
  static const Duration contentAnimDelay = Duration(milliseconds: 80);
  static const Duration dotAnimDuration = Duration(milliseconds: 260);
  static const Duration buttonAnimDuration = Duration(milliseconds: 220);
  static const Duration bgGradientDuration = Duration(milliseconds: 600);
  static const Duration navigationFadeDuration = Duration(milliseconds: 500);

  // ─── Content animation offsets ─────────────────────────────────────────────
  static const double titleSlideOffset = 28.0;
  static const double descSlideOffset = 44.0;

  // ─── Page indicator ────────────────────────────────────────────────────────
  static const double dotActivWidth = 28.0;
  static const double dotInactiveWidth = 8.0;
  static const double dotHeight = 8.0;
  static const double dotSpacing = 6.0;
  static const double dotBorderRadius = 4.0;

  // ─── Button sizing ─────────────────────────────────────────────────────────
  static const double nextButtonHeight = 58.0;
  static const double nextButtonRadius = 16.0;
  static const double nextButtonHorizontalPadding = 24.0;
  static const double skipButtonFontSize = 14.0;

  // ─── Typography ────────────────────────────────────────────────────────────
  static const double titleFontSize = 28.0;
  static const double descFontSize = 15.0;
  static const double titleLetterSpacing = 0.4;
  static const double descLineHeight = 1.75;

  // ─── Layout spacing ────────────────────────────────────────────────────────
  static const double illustrationAreaFlex = 5;
  static const double contentAreaFlex = 4;
  static const double contentHorizontalPadding = 28.0;
  static const double spacingBelowIllustration = 0.0;
  static const double spacingTitleToDesc = 14.0;
  static const double spacingDescToIndicator = 36.0;
  static const double spacingIndicatorToButton = 24.0;
  static const double bottomSafeAreaPadding = 32.0;

  // ─── Illustration sizing ───────────────────────────────────────────────────
  static const double lottieHeightFraction = 0.38;

  // ─── Gradient colours per page ─────────────────────────────────────────────
  static const List<Color> bgTopColors = [
    Color(0xFF0F2D31), // page 0
    Color(0xFF0D2A2A), // page 1
    Color(0xFF0A2520), // page 2
  ];
}
