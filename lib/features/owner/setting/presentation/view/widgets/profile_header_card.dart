import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/profile_avatar.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/user_info_section.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    super.key,
    required this.username,
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.imageUrl,
    required this.onEditPressed,
  });

  final String username;
  final String fullName;
  final String birthDate;
  final String gender;
  final String imageUrl;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final avatarRadius = size.width * 0.12;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            AppColors.colorBtnAndCard.withOpacity(0.8),
            AppColors.colorBtnAndCard,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        color: AppColors.colorBtnAndCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Profile Image
          ProfileAvatar(imageUrl: imageUrl, radius: avatarRadius),
          SizedBox(width: size.width * 0.05),

          Expanded(
            child: UserInfoSection(
              username: username,
              fullName: fullName,
              birthDate: birthDate,
              gender: gender,
              onEditPressed: onEditPressed,
            ),
          ),
        ],
      ),
    );
  }
}
