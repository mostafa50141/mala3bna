import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/icon_container.dart';

class SettingsSwitchTile extends StatefulWidget {
  const SettingsSwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  State<SettingsSwitchTile> createState() => _SettingsSwitchTileState();
}

class _SettingsSwitchTileState extends State<SettingsSwitchTile> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.colorBtnAndCard,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              AppColors.colorBtnAndCard.withOpacity(0.8),
              AppColors.colorBtnAndCard,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            IconContainer(icon: widget.icon),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: Style.textStyle16Bold),
                  const SizedBox(height: 4),
                  Text(
                    isEnabled ? "Enabled" : "Disabled",
                    style: Style.textStyle12Bold.copyWith(
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            ),

            Switch(
              value: isEnabled,
              activeColor: AppColors.primaryColor,
              onChanged: (value) {
                setState(() {
                  isEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
