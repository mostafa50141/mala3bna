import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
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
        PremiumThemeTile(
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

class PremiumThemeTile extends StatelessWidget {
  final VoidCallback onTap;
  const PremiumThemeTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          splashColor: AppColors.primaryColor.withValues(alpha: 0.15),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withValues(alpha: 0.12),
                  Theme.of(context).cardColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.primaryColor.withValues(alpha: 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.brightness_6_rounded,
                      color: AppColors.primaryColor,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'App Theme'.tr,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Customize your visual experience'.tr,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6) ?? Colors.white.withValues(alpha: 0.6),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.black26 : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white12 : Colors.black12, 
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          Theme.of(context).brightness == Brightness.dark ? 'Dark'.tr : 'Light'.tr,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.54) ?? Colors.white54,
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
