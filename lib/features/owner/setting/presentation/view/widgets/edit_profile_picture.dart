import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

class EditProfilePicture extends StatelessWidget {
  const EditProfilePicture({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 1),
              image: DecorationImage(
                image: AssetImage("assets/images/app_logo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor.withOpacity(0.8),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primaryColor, width: 1),
              ),
              child: Icon(
                Icons.camera_alt,
                color: AppColors.primaryColor,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
