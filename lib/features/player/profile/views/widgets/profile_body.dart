import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mala3bna/features/player/profile/data/repos/user_profile_repo.dart';
import 'package:mala3bna/features/player/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:mala3bna/features/player/profile/presentation/cubit/user_profile_state.dart';
import 'package:mala3bna/core/widgets/custome_circular_laoding.dart';
import 'package:mala3bna/features/player/profile/views/my_bookings_views.dart';
import 'package:mala3bna/features/player/profile/views/widgets/profile_menu_item.dart';
import 'package:mala3bna/features/player/profile/views/widgets/profile_stats_row.dart';
import 'package:mala3bna/features/player/settings/views/settings_view.dart';
import 'package:mala3bna/features/player/payments/views/payments_view.dart';
import 'package:mala3bna/features/player/terms/views/terms_view.dart';
import 'package:mala3bna/features/player/help/views/help_view.dart';
import 'package:mala3bna/features/auth/presentation/data/auth_controller.dart';
import 'package:mala3bna/features/welcome_screen/presentation/views/welcome_screen.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String _name = '';
  String _email = '';
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final storage = getIt.get<LocalStorageHelper>();
    final name = await storage.getUserName();
    final email = await storage.getUserEmail();
    final imagePath = await storage.getProfileImagePath();
    setState(() {
      _name = name;
      _email = email;
      _profileImagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit(getIt.get<UserProfileRepo>())..getProfile(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Gap(20),
          BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              String displayEmail = _email.isNotEmpty ? _email : 'Loading...';
              String displayName = _name.isNotEmpty ? _name : 'Loading...';
              Widget avatarChild;

              if (state is UserProfileLoading) {
                avatarChild = const CustomeCircularLaoding();
              } else if (state is UserProfileLoaded) {
                displayEmail = state.profile.email;
                displayName = state.profile.fullName;
                if (state.profile.profileImage != null) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor.withOpacity(0.07),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: state.profile.profileImage!,
                          imageBuilder: (context, imageProvider) => CircleAvatar(
                            radius: 40,
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (context, url) => const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.transparent,
                            child: CustomeCircularLaoding(),
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey.shade800,
                            child: const Icon(Icons.person, color: Colors.white, size: 40),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Text(
                        displayName,
                        style: Style.textStyle20Bold.copyWith(color: Colors.white),
                      ),
                      const Gap(4),
                      Text(
                        displayEmail,
                        style: Style.textStyle14.copyWith(color: Colors.grey),
                      ),
                    ],
                  );
                } else {
                  avatarChild = const Icon(Icons.person, color: Colors.white, size: 40);
                }
              } else {
                avatarChild = CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade800,
                  backgroundImage: _profileImagePath != null
                      ? FileImage(File(_profileImagePath!))
                      : null,
                  child: _profileImagePath == null
                      ? const Icon(Icons.person, color: Colors.white, size: 40)
                      : null,
                );
              }

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor.withOpacity(0.07),
                    ),
                    child: state is UserProfileLoading ? CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade800,
                      child: avatarChild,
                    ) : (avatarChild is CircleAvatar ? avatarChild : CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade800,
                      child: avatarChild,
                    )),
                  ),
                  const Gap(12),
                  Text(
                    displayName,
                    style: Style.textStyle20Bold.copyWith(color: Colors.white),
                  ),
                  const Gap(4),
                  Text(
                    displayEmail,
                    style: Style.textStyle14.copyWith(color: Colors.grey),
                  ),
                ],
              );
            },
          ),
          const Gap(24),
          const ProfileStatsRow(),
          const Gap(24),
          const Align(
            alignment: Alignment.centerLeft,
            child: SectionTitle(title: 'Account'),
          ),
          const Gap(16),
          ProfileMenuItem(
            icon: Icons.calendar_today,
            label: 'My Bookings',
            onTap: () {
              // Navigate to bookings page
              Get.to(() => const MyBookingsViews());
            },
          ),
          ProfileMenuItem(
            icon: Icons.payment,
            label: 'Payments',
            onTap: () {
              Get.to(() => const PaymentsView());
            },
          ),
          ProfileMenuItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () {
              Get.to(() => const SettingsView())?.then((_) => _loadUserData());
            },
          ),
          ProfileMenuItem(
            icon: Icons.help_outline,
            label: 'Help',
            onTap: () {
              Get.to(() => const HelpView());
            },
          ),
          ProfileMenuItem(
            icon: Icons.description_outlined,
            label: 'Terms & Conditions',
            onTap: () {
              Get.to(() => const TermsView());
            },
          ),
          ProfileMenuItem(
            icon: Icons.logout,
            label: 'Logout',
            isDanger: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppColors.colorBtnAndCard,
                  title: Text(
                    'Logout',
                    style: Style.textStyle18Bold.copyWith(color: Colors.white),
                  ),
                  content: Text(
                    'Are you sure you want to logout?',
                    style: Style.textStyle14.copyWith(color: Colors.grey),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: Style.textStyle14Bold.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        final authController = Get.find<AuthController>();
                        authController.logout();
                        await getIt.get<LocalStorageHelper>().deletetoken();
                        await getIt.get<LocalStorageHelper>().deleteUserData();
                        Get.offAll(() => const WelcomeScreen());
                      },
                      child: Text(
                        'Logout',
                        style: Style.textStyle14Bold.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ));
  }
}
