import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,

    required this.height,
    required this.text1,
    required this.text2,
  });
  final double height;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFF2B3A41),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(10),
          Text(
            text1,
            style: Style.textStyle16Bold.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          Text(text2, style: Style.textStyle16Bold),
          Gap(20),
        ],
      ),
    );
  }
}
