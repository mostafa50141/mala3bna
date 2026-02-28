import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Select Language", style: Style.textStyle18Bold),
          const SizedBox(height: 10),
          const Divider(color: Colors.white24),
          const SizedBox(height: 10),
          ListTile(
            title: const Text("English", style: Style.textStyle16Bold),
            onTap: () {
              // change language
              Navigator.pop(context);
            },
          ),

          ListTile(
            title: const Text("العربية", style: Style.textStyle16Bold),
            onTap: () {
              // change language
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
