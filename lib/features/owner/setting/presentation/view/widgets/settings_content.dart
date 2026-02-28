import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/language_bottom_sheet.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/setting_tile.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/settings_switch_tile.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/theme_bottom_sheet.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSwitchTile(
          icon: Icons.notifications_none,
          title: "Push Notifications",
          subtitle: "Enabled",
        ),
        SettingsTile(
          icon: Icons.color_lens_outlined,
          title: "App Theme",
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) => const ThemeBottomSheet(),
            );
          },
        ),
        SettingsTile(
          icon: Icons.language_outlined,
          title: "Language",
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) => const LanguageBottomSheet(),
            );
          },
        ),
        SettingsTile(icon: Icons.person_outline, title: "Change Personal Info"),
        SettingsTile(icon: Icons.lock_outline, title: "Change Password"),
        SettingsTile(icon: Icons.help_outline, title: "Need Help?"),
        SettingsTile(
          icon: Icons.delete_outline,
          title: "Delete Account",
          isDanger: true,
        ),
        SettingsTile(icon: Icons.description_outlined, title: "Privacy Policy"),
        SettingsTile(
          icon: Icons.verified_user_outlined,
          title: "Terms & Conditions",
        ),
      ],
    );
  }
}
