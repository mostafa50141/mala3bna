import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

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
          const Text("Select Theme", style: Style.textStyle18Bold),
          const SizedBox(height: 10),
          const Divider(color: Colors.white24),
          const SizedBox(height: 10),
          ListTile(
            title: const Text("Light", style: Style.textStyle16Bold),
            onTap: () {
              // change theme
              Navigator.pop(context);
            },
          ),

          ListTile(
            title: const Text("Dark", style: Style.textStyle16Bold),
            onTap: () {
              // change theme
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
