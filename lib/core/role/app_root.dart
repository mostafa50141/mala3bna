import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/role/user_role.dart';
import 'package:mala3bna/features/auth/presentation/data/auth_controller.dart';
import 'package:mala3bna/features/auth/presentation/views/login_screen.dart';
import 'package:mala3bna/core/navigation/coach_main_navigation.dart';
import 'package:mala3bna/core/navigation/owner_main_navigation.dart';
import 'package:mala3bna/core/navigation/player_main_navigation.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() {
      final role = authController.userRole.value;

      if (role == null) {
        return const LoginScreen();
      }

      switch (role) {
        case UserRole.player:
          return const PlayerMainNavigation();
        case UserRole.owner:
          return const OwnerMainNavigation();
        case UserRole.coach:
          return const CoachMainNavigation();
      }
    });
  }
}
