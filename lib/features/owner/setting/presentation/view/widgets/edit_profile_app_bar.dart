import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class EditProfileAppBar extends StatelessWidget {
  const EditProfileAppBar({super.key});

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
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(CupertinoIcons.back, color: AppColors.primaryColor),
          ),
        ),
        const SizedBox(width: 20),
        Text('Edit Profile', style: Style.textStyle20Bold),
      ],
    );
  }
}
