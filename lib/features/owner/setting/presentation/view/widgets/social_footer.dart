import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';

class SocialFooter extends StatelessWidget {
  const SocialFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.instagram,
                color: AppColors.primaryColor,
                size: 25,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.tiktok,
                color: AppColors.primaryColor,
                size: 25,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.facebook,
                color: AppColors.primaryColor,
                size: 25,
              ),
              onPressed: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Privacy Policy',
                style: Style.textStyle14Bold.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Text('•', style: TextStyle(color: AppColors.primaryColor)),
            TextButton(
              onPressed: () {},
              child: Text(
                'Terms & Conditions',
                style: Style.textStyle14Bold.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
