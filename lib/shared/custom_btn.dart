import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/shared/custom_text.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.text,
    this.onTap,
    required this.height,
    required this.width,
    required this.radius,
    this.color,
  });
  final String text;
  final Function()? onTap;
  final double height;
  final double width;
  final double radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customText(
              text: text,
              color: Colors.white,
              size: 18,
              weight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
