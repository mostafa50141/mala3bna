import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// A reusable card container used by Pricing, Amenities, Ratings, etc.
class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BorderSide? accentLeft;

  const SectionCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.accentLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? AppColors.colorBtnAndCard,
        borderRadius: BorderRadius.circular(16),
        border: accentLeft != null ? Border(left: accentLeft!) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// A consistent section title row with optional trailing widget.
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
