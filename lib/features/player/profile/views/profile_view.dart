import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/player/profile/views/widgets/profile_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Profile',
          style: Style.textStyle20Bold.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: const ProfileBody(),
    );
  }
}
