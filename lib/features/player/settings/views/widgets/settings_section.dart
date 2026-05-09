import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:gap/gap.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title),
        const Gap(16),
        ...children,
        const Gap(24),
      ],
    );
  }
}
