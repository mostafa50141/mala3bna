import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/settings/views/widgets/settings_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Settings',
          style: Style.textStyle20Bold.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const SettingsBody(),
    );
  }
}
