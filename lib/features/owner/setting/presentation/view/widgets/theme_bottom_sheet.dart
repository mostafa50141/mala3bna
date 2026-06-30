import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/controllers/theme_controller.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Select Theme".tr, style: Style.textStyle18Bold),
          const SizedBox(height: 10),
          const Divider(color: Colors.white24),
          const SizedBox(height: 10),
          ListTile(
            title: Text("Light".tr, style: Style.textStyle16Bold),
            onTap: () {
              Get.find<ThemeController>().setThemeMode(false);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Dark".tr, style: Style.textStyle16Bold),
            onTap: () {
              Get.find<ThemeController>().setThemeMode(true);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
