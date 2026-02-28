import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class SettingAppBar extends StatelessWidget {
  const SettingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.colorBtnAndCard,
            border: Border.all(color: AppColors.primaryColor, width: .5),
          ),
          child: Icon(Icons.settings, color: AppColors.primaryColor, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Profile", style: Style.textStyle20Bold),
            const SizedBox(height: 1),
            Text(
              "Manage your Account",
              style: Style.textStyle14Bold.copyWith(color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            //borderRadius: BorderRadius.circular(12),
            color: Colors.redAccent.withOpacity(.1),
            border: Border.all(
              color: const Color.fromARGB(147, 242, 94, 84),
              width: .5,
            ),
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.logout,
              color: const Color.fromARGB(147, 242, 94, 84),
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
