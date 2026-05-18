import 'package:flutter/material.dart';

/// Represents the content of a single onboarding page.
///
/// Immutable data object — all fields are required and final.
/// The [lottieAsset] path is relative to the project root (assets/animations/).
class OnboardingPageModel {
  final String title;
  final String description;
  final String lottieAsset;
  final Color accentColor;

  const OnboardingPageModel({
    required this.title,
    required this.description,
    required this.lottieAsset,
    required this.accentColor,
  });
}
