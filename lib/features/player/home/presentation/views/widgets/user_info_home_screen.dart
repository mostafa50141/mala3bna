import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class UserInfoInHomeScreen extends StatelessWidget {
  const UserInfoInHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(8),

        CircleAvatar(
          radius: 22,
          backgroundImage: AssetImage('assets/images/MyPhoto.jpg'),
        ),

        Gap(15),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hi, Mostafa 👋🏻',
              style: Style.textStyle18Bold.copyWith(color: Colors.white),
            ),

            Gap(4),

            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: AppColors.primaryColor),
                Gap(4),
                Text('Nasr City', style: Style.textStyle12.copyWith(color: Colors.grey)),
              ],
            ),
          ],
        ),

        Spacer(),

        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_on_sharp),
            iconSize: 22,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
