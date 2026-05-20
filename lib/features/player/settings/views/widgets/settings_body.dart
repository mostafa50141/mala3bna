import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/settings/views/change_password_view.dart';
import 'package:mala3bna/features/player/settings/views/widgets/settings_section.dart';
import 'package:mala3bna/features/player/settings/views/widgets/settings_tile.dart';
import 'package:mala3bna/features/player/settings/views/widgets/settings_switch_tile.dart';
import 'package:mala3bna/features/player/settings/views/edit_profile_view.dart';
import 'package:get/get.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  String _selectedLanguage = 'English';

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.colorBtnAndCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            'Select Language',
            style: Style.textStyle18Bold.copyWith(color: Colors.white),
          ),
          const Divider(color: Colors.white24),
          ListTile(
            title: Text(
              'English',
              style: Style.textStyle16Bold.copyWith(color: Colors.white),
            ),
            trailing: _selectedLanguage == 'English'
                ? Icon(Icons.check, color: AppColors.primaryColor)
                : null,
            onTap: () {
              setState(() => _selectedLanguage = 'English');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'العربية',
              style: Style.textStyle16Bold.copyWith(color: Colors.white),
            ),
            trailing: _selectedLanguage == 'Arabic'
                ? Icon(Icons.check, color: AppColors.primaryColor)
                : null,
            onTap: () {
              setState(() => _selectedLanguage = 'Arabic');
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsSection(
            title: 'Account',
            children: [
              SettingsTile(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                subtitle: 'Change your name, email, avatar',
                onTap: () {
                  Get.to(() => const EditProfileView());
                },
              ),
              SettingsTile(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle: 'Update your password for security',
                onTap: () {
                  Get.to(() => const ChangePasswordView());
                },
              ),
            ],
          ),
          SettingsSection(
            title: 'Preferences',
            children: [
              SettingsTile(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'Change app language',
                trailing: Text(
                  _selectedLanguage,
                  style: Style.textStyle14.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                onTap: () {
                  _showLanguageBottomSheet(context);
                },
              ),
              SettingsSwitchTile(
                icon: Icons.notifications_none,
                title: 'Notifications',
                subtitle: 'Enable or disable push notifications',
                initialValue: true,
                onChanged: (val) {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Danger Zone',
            children: [
              SettingsTile(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                subtitle: 'Permanently remove your account and data',
                isDanger: true,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
