import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/controllers/locale_controller.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/language_bottom_sheet.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/theme_bottom_sheet.dart';
import 'package:mala3bna/features/player/profile/data/repos/user_profile_repo.dart';
import 'package:mala3bna/features/player/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:mala3bna/features/player/settings/views/change_password_view.dart';
import 'package:mala3bna/features/player/settings/views/edit_profile_view.dart';
import 'package:mala3bna/features/player/settings/views/widgets/delete_account_bottom_sheet.dart';
import 'package:mala3bna/features/player/settings/views/widgets/settings_section.dart';
import 'package:mala3bna/features/player/settings/views/widgets/settings_switch_tile.dart';
import 'package:mala3bna/features/player/settings/views/widgets/settings_tile.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  void _showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const ThemeBottomSheet(),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const LanguageBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserProfileCubit(getIt.get<UserProfileRepo>()),
      child: Builder(
        builder: (innerContext) => SingleChildScrollView(
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
                    icon: Icons.brightness_6_rounded,
                    title: 'App Theme',
                    subtitle: 'Customize your visual experience',
                    trailing: Text(
                      Theme.of(context).brightness == Brightness.dark
                          ? 'Dark'
                          : 'Light',
                      style: Style.textStyle14.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    onTap: () {
                      _showThemeBottomSheet(context);
                    },
                  ),
                  SettingsTile(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'Change app language',
                    trailing: GetBuilder<LocaleController>(
                      builder: (localeCtrl) => Text(
                        localeCtrl.isArabic ? 'Arabic' : 'English',
                        style: Style.textStyle14.copyWith(
                          color: AppColors.primaryColor,
                        ),
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
                    onTap: () {
                      final cubit = innerContext.read<UserProfileCubit>();
                      showModalBottomSheet<void>(
                        context: innerContext,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (sheetContext) => BlocProvider.value(
                          value: cubit,
                          child: const DeleteAccountBottomSheet(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
