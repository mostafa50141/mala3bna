import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Style.textStyle20Bold.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
