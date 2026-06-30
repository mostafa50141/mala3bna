import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/auth/presentation/data/auth_controller.dart';
import 'package:mala3bna/features/welcome_screen/presentation/views/welcome_screen.dart';
import 'package:flutter/services.dart';

class SettingAppBar extends StatelessWidget {
  const SettingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primaryColor.withValues(alpha: 0.12),
            border: Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Icon(
            Icons.manage_accounts_outlined,
            color: AppColors.primaryColor,
            size: 22,
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile & Settings'.tr,
              style: TextStyle(
                color:
                    Theme.of(context).textTheme.bodyMedium?.color ??
                    Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Manage your account'.tr,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        const Spacer(),
        Tooltip(
          message: 'Log out',
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogCtx) => AlertDialog(
                  backgroundColor: AppColors.colorBtnAndCard,
                  title: Text(
                    'Logout',
                    style: Style.textStyle18Bold.copyWith(color: Colors.white),
                  ),
                  content: Text(
                    'Are you sure you want to logout?',
                    style: Style.textStyle14.copyWith(color: Colors.grey),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: Style.textStyle14Bold.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        final authController = Get.find<AuthController>();
                        authController.logout();
                        await getIt.get<LocalStorageHelper>().deletetoken();
                        await getIt.get<LocalStorageHelper>().deleteUserData();
                        Get.offAll(() => const WelcomeScreen());
                      },
                      child: Text(
                        'Logout',
                        style: Style.textStyle14Bold.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            //onTap: () => _confirmLogout(context),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent.withValues(alpha: 0.10),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.45),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: Colors.redAccent,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
