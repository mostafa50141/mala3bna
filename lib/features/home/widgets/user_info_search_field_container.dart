import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/home/widgets/search_field.dart';
import 'package:mala3bna/features/home/widgets/user_info_home_screen.dart';

class UserInfoAndSearchFieldContainer extends StatelessWidget {
  const UserInfoAndSearchFieldContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        gradient: LinearGradient(
          colors: [AppColors.backgroundColor, AppColors.primaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [UserInfoInHomeScreen(), Gap(25), SearchField()],
        ),
      ),
    );
  }
}
