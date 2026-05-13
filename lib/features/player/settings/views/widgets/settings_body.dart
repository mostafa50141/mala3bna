import 'package:flutter/material.dart';
import 'package:mala3bna/features/player/settings/views/widgets/settings_section.dart';
import 'package:mala3bna/features/player/settings/views/widgets/settings_tile.dart';
import 'package:mala3bna/features/player/settings/views/widgets/settings_switch_tile.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

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
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle: 'Update your password for security',
                onTap: () {},
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
                trailing: const Text('English', style: TextStyle(color: Colors.grey, fontSize: 13)),
                onTap: () {},
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
