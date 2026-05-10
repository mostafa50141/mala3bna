import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/utils/style.dart';

class TermsSection extends StatelessWidget {
  final String title;
  final String content;

  const TermsSection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Style.textStyle18Bold.copyWith(color: Colors.white)),
        const Gap(8),
        Text(
          content,
          style: Style.textStyle14.copyWith(color: Colors.white70, height: 1.5),
        ),
        const Gap(24),
      ],
    );
  }
}
