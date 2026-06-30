/// Splash screen animation constants — all hardcoded values live here.
/// Any timing or sizing change should be made exclusively in this file.
class SplashConstants {
  SplashConstants._(); // prevent instantiation

  // ─── Controller duration ───────────────────────────────────────────────────
  static const Duration totalDuration = Duration(milliseconds: 2400);

  // ─── Background breathing controller ──────────────────────────────────────
  static const Duration bgBreathDuration = Duration(seconds: 4);

  // ─── Logo scale (0 ms → 600 ms  =  0.0 → 0.25 of total) ──────────────────
  static const double logoScaleBegin = 0.4;
  static const double logoScaleEnd = 1.0;
  static const double logoScaleIntervalStart = 0.0;
  static const double logoScaleIntervalEnd = 0.25;

  // ─── Logo opacity (same interval as scale) ─────────────────────────────────
  static const double logoOpacityBegin = 0.0;
  static const double logoOpacityEnd = 1.0;
  static const double logoOpacityIntervalStart = 0.0;
  static const double logoOpacityIntervalEnd = 0.25;

  // ─── App name slide (700 ms → 1 200 ms  =  0.29 → 0.50) ──────────────────
  static const double nameSlideBeginDy = 0.4;
  static const double nameSlideIntervalStart = 0.29;
  static const double nameSlideIntervalEnd = 0.50;

  // ─── App name opacity (same interval as slide) ────────────────────────────
  static const double nameOpacityBegin = 0.0;
  static const double nameOpacityEnd = 1.0;
  static const double nameOpacityIntervalStart = 0.29;
  static const double nameOpacityIntervalEnd = 0.50;

  // ─── Tagline opacity (1 300 ms → 1 700 ms  =  0.54 → 0.71) ───────────────
  static const double tagOpacityBegin = 0.0;
  static const double tagOpacityEnd = 1.0;
  static const double tagOpacityIntervalStart = 0.54;
  static const double tagOpacityIntervalEnd = 0.71;

  // ─── Shimmer sweep (1 800 ms → 2 400 ms  =  0.75 → 1.0) ──────────────────
  static const double shimmerIntervalStart = 0.75;
  static const double shimmerIntervalEnd = 1.0;

  // ─── Navigation transition ─────────────────────────────────────────────────
  static const Duration navigationFadeDuration = Duration(milliseconds: 600);

  // ─── Layout sizing ─────────────────────────────────────────────────────────
  static const double logoSize = 160.0;
  static const double appNameFontSize = 36.0;
  static const double taglineFontSize = 15.0;
  static const double verticalSpacingLogo = 28.0;
  static const double verticalSpacingTagline = 10.0;

  // ─── Background gradient opacity range ────────────────────────────────────
  static const double bgOverlayMin = 0.55;
  static const double bgOverlayMax = 0.70;

  // ─── Shimmer highlight intensity ───────────────────────────────────────────
  static const double shimmerHighlightOpacity = 0.35;

  // ─── Divider line sizing ───────────────────────────────────────────────────
  static const double taglineDividerWidth = 40.0;
  static const double taglineDividerThickness = 1.0;
}
