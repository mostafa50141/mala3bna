import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

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
            const Text(
              'Profile & Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Manage your account',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ],
        ),
        const Spacer(),
        Tooltip(
          message: 'Log out',
          child: InkWell(
            onTap: () {},
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
