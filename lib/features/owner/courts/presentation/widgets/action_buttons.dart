import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/widgets/custom_btn.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomBtn(
            text: "Edit Court",
            onTap: () {},
            height: 45,
            width: double.infinity,
            radius: 10,
            color: AppColors.primaryColor,
            colorText: Colors.white,
            weightText: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CustomBtn(
            text: "Disable Court",
            onTap: () {},
            height: 45,
            width: double.infinity,
            radius: 10,
            color: Colors.transparent,
            border: Border.all(color: Colors.grey),
            colorText: Colors.grey,
            weightText: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
