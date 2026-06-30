import 'package:flutter/material.dart';

/// A single section inside the Privacy Policy document.
class PrivacySection {
  final String title;
  final String body;
  final IconData icon;

  /// Optional badge label displayed next to the title (e.g. "SSL SECURE").
  final String? badge;

  const PrivacySection({
    required this.title,
    required this.body,
    required this.icon,
    this.badge,
  });
}
