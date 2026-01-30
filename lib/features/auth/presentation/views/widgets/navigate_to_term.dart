import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class NavigateToTerms extends StatelessWidget {
  const NavigateToTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Style.textStyle16.copyWith(color: AppColors.fieldBackground),
            children: [
              TextSpan(text: "By creating an account, you agree to our "),
              TextSpan(
                text: "Terms of Service",
                style: Style.textStyle16Bold.copyWith(
                  color: AppColors.primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // navigate to terms
                  },
              ),
              TextSpan(text: " and "),
              TextSpan(
                text: "Privacy Policy",
                style: Style.textStyle16Bold.copyWith(
                  color: AppColors.primaryColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // navigate to privacy
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
