import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:mala3bna/features/player/profile/views/widgets/profile_menu_item.dart';
import 'package:mala3bna/features/player/profile/views/widgets/profile_stats_row.dart';

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
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF39E079),
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent,
              child: Icon(Icons.person, size: 40, color: Colors.white),
            ),
          ),
          const Gap(12),
          Text(
            'Mostafa Abdelaziz',
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
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.payment,
            label: 'Payments',
            onTap: () {},
          ),
          ProfileMenuItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () {},
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
