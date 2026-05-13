import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/settings/views/widgets/icon_container.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.isDanger = false,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool isDanger;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final titleColor = isDanger ? Colors.redAccent : Colors.white;
    final arrowColor = isDanger ? Colors.redAccent.withValues(alpha: 0.5) : Colors.white24;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap ?? () {},
          splashColor: isDanger
              ? Colors.redAccent.withValues(alpha: 0.08)
              : AppColors.primaryColor.withValues(alpha: 0.08),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.colorBtnAndCard,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  IconContainer(icon: icon, isDanger: isDanger),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Style.textStyle14Bold.copyWith(color: titleColor),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: const TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    trailing!,
                    const SizedBox(width: 8),
                  ],
                  Icon(Icons.arrow_forward_ios_rounded, size: 14, color: arrowColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
