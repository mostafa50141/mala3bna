import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/local_storage_helper.dart';
import 'package:mala3bna/core/utils/service_locator.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custom_circular_loading.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:mala3bna/features/auth/presentation/data/auth_controller.dart';
import 'package:mala3bna/features/player/help/views/help_view.dart';
import 'package:mala3bna/features/player/payments/views/payments_view.dart';
import 'package:mala3bna/features/player/profile/data/repos/user_profile_repo.dart';
import 'package:mala3bna/features/player/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:mala3bna/features/player/profile/presentation/cubit/user_profile_state.dart';
import 'package:mala3bna/features/player/profile/views/my_bookings_views.dart';
import 'package:mala3bna/features/player/profile/views/widgets/profile_menu_item.dart';
import 'package:mala3bna/features/player/profile/views/widgets/profile_stats_row.dart';
import 'package:mala3bna/features/player/settings/views/settings_view.dart';
import 'package:mala3bna/features/player/terms/views/terms_view.dart';
import 'package:mala3bna/features/welcome_screen/presentation/views/welcome_screen.dart';

// ── Outer wrapper: owns the BlocProvider ────────────────────────────────────
class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          UserProfileCubit(getIt.get<UserProfileRepo>())..getProfile(),
      child: const _ProfileBodyContent(),
    );
  }
}

// ── Inner content: reads from the cubit ─────────────────────────────────────
class _ProfileBodyContent extends StatelessWidget {
  const _ProfileBodyContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Gap(20),
          // ── Avatar + name + email ────────────────────────────────
          BlocBuilder<UserProfileCubit, UserProfileState>(
            builder: (context, state) {
              if (state is UserProfileLoading) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 43,
                      backgroundColor: Colors.grey.shade800,
                      child: const CustomeCircularLaoding(),
                    ),
                    const Gap(12),
                    Text(
                      'Loading...',
                      style: Style.textStyle20Bold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }

              if (state is UserProfileLoaded || state is UserProfileUpdated) {
                final profile = state is UserProfileLoaded
                    ? state.profile
                    : (state as UserProfileUpdated).profile;

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor.withOpacity(0.1),
                      ),
                      child: profile.profileImage != null
                          ? CachedNetworkImage(
                              imageUrl: profile.profileImage!,
                              imageBuilder: (ctx, imageProvider) =>
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: imageProvider,
                                  ),
                              placeholder: (ctx, url) => CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey.shade800,
                                child: const CustomeCircularLaoding(),
                              ),
                              errorWidget: (ctx, url, err) => CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey.shade800,
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey.shade800,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                    ),
                    const Gap(12),
                    Text(
                      profile.fullName.isNotEmpty
                          ? profile.fullName
                          : profile.username,
                      style: Style.textStyle20Bold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      profile.email,
                      style: Style.textStyle14.copyWith(color: Colors.grey),
                    ),
                    if (profile.phoneNumber != null &&
                        profile.phoneNumber!.isNotEmpty) ...[
                      const Gap(4),
                      Text(
                        profile.phoneNumber!,
                        style: Style.textStyle12.copyWith(color: Colors.grey),
                      ),
                    ],
                  ],
                );
              }

              // Failure / Initial: fall back to locally cached data
              return _LocalProfileFallback();
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
            onTap: () => Get.to(() => const MyBookingsViews()),
          ),
          ProfileMenuItem(
            icon: Icons.payment,
            label: 'Payments',
            onTap: () => Get.to(() => const PaymentsView()),
          ),
          ProfileMenuItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () {
              Get.to(() => const SettingsView())?.then((_) {
                // Refresh profile when returning from settings
                if (context.mounted) {
                  context.read<UserProfileCubit>().getProfile();
                }
              });
            },
          ),
          ProfileMenuItem(
            icon: Icons.help_outline,
            label: 'Help',
            onTap: () => Get.to(() => const HelpView()),
          ),
          ProfileMenuItem(
            icon: Icons.description_outlined,
            label: 'Terms & Conditions',
            onTap: () => Get.to(() => const TermsView()),
          ),
          ProfileMenuItem(
            icon: Icons.logout,
            label: 'Logout',
            isDanger: true,
            onTap: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
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
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(
                        'Cancel',
                        style: Style.textStyle14Bold.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(dialogContext);
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
    );
  }
}

// ── Local-cache fallback widget ──────────────────────────────────────────────
class _LocalProfileFallback extends StatefulWidget {
  @override
  State<_LocalProfileFallback> createState() => _LocalProfileFallbackState();
}

class _LocalProfileFallbackState extends State<_LocalProfileFallback> {
  String _name = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final storage = getIt.get<LocalStorageHelper>();
    final name = await storage.getUserName();
    final email = await storage.getUserEmail();
    if (mounted)
      setState(() {
        _name = name;
        _email = email;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 43,
          backgroundColor: Colors.grey.shade800,
          child: const Icon(Icons.person, color: Colors.white, size: 40),
        ),
        const Gap(12),
        Text(
          _name.isNotEmpty ? _name : '—',
          style: Style.textStyle20Bold.copyWith(color: Colors.white),
        ),
        const Gap(4),
        Text(
          _email.isNotEmpty ? _email : '—',
          style: Style.textStyle14.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
