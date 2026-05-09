import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:mala3bna/features/player/profile/views/my_bookings_views.dart';
import 'package:mala3bna/features/player/profile/views/widgets/profile_menu_item.dart';
import 'package:mala3bna/features/player/profile/views/widgets/profile_stats_row.dart';
import 'package:mala3bna/features/player/settings/views/settings_view.dart';
import 'package:mala3bna/features/player/payments/views/payments_view.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Gap(20),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withOpacity(0.07),
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/pfp.jpg'),
            ),
          ),
          const Gap(12),
          Text(
            'Mostafa Ahmed',
            style: Style.textStyle20Bold.copyWith(color: Colors.white),
          ),
          const Gap(4),
          Text(
            'mostafa@gmail.com',
            style: Style.textStyle14.copyWith(color: Colors.grey),
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
              Get.to(() => const SettingsView());
            },
          ),
          ProfileMenuItem(
            icon: Icons.help_outline,
            label: 'Help',
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.description_outlined,
            label: 'Terms & Conditions',
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.logout,
            label: 'Logout',
            isDanger: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
