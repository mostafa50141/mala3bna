import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/widgets/custom_text.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.text,
    this.onTap,
    required this.height,
    required this.width,
    required this.radius,
    this.color,
    this.border,
    this.colorText,
    this.sizeText,
    this.weightText,
    this.isLoading = false,
  });

  final String text;
  final Function()? onTap;
  final double height;
  final double width;
  final double radius;
  final Color? color;
  final BoxBorder? border;
  final Color? colorText;
  final double? sizeText;
  final FontWeight? weightText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(radius),
            border: border,
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : customText(
                    text: text,
                    color: colorText ?? Colors.white,
                    size: sizeText,
                    weight: weightText,
                  ),
          ),
        ),
      ),
    );
  }
}
