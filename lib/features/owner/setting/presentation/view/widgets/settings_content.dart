import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:mala3bna/features/owner/setting/presentation/cubit/owner_profile_cubit.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/change_password_view.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/delete_account_view.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/edit_profile_view.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/help_center_view.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/privacy_policy_view.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/terms_and_conditions_view.dart';
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
          title: 'Push Notifications'.tr,
          subtitle: 'Enabled'.tr,
        ),
        SettingsTile(
          icon: Icons.color_lens_outlined,
          title: 'App Theme'.tr,
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
          title: 'Language'.tr,
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (_) => const LanguageBottomSheet(),
            );
          },
        ),
        SettingsTile(
          icon: Icons.person_outline,
          title: 'Change Personal Info'.tr,
          onTap: () {
            final cubit = context.read<OwnerProfileCubit>();
            navigator?.push(
              GetPageRoute(
                page: () => BlocProvider.value(
                  value: cubit,
                  child: const EditProfileView(),
                ),
                transition: Transition.rightToLeft,
              ),
            );
          },
        ),
        SettingsTile(
          icon: Icons.lock_outline,
          title: 'Change Password'.tr,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ChangePasswordView(),
              ),
            );
          },
        ),
        SettingsTile(
          icon: Icons.help_outline,
          title: 'Need Help?'.tr,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const HelpCenterView(),
              ),
            );
          },
        ),
        SettingsTile(
          icon: Icons.delete_outline,
          title: 'Delete Account'.tr,
          isDanger: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DeleteAccountView(),
              ),
            );
          },
        ),
        SettingsTile(
          icon: Icons.description_outlined,
          title: 'Privacy Policy'.tr,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PrivacyPolicyView(),
              ),
            );
          },
        ),
        SettingsTile(
          icon: Icons.verified_user_outlined,
          title: 'Terms & Conditions'.tr,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TermsAndConditionsView(),
              ),
            );
          },
        ),
      ],
    );
  }
}
