import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isDanger;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.colorBtnAndCard,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isDanger
                    ? Colors.redAccent.withOpacity(0.1)
                    : AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isDanger ? Colors.redAccent : AppColors.primaryColor,
                size: 20,
              ),
            ),
            const Gap(16),
            Expanded(
              child: Text(
                label,
                style: Style.textStyle16.copyWith(
                  color: isDanger ? Colors.redAccent : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDanger ? Colors.redAccent : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
