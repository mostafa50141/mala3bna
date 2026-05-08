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
    final size = MediaQuery.sizeOf(context);
    final avatarRadius = size.width * 0.12;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.045),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border(
          left: BorderSide(color: AppColors.primaryColor, width: 3),
        ),
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor.withValues(alpha: 0.12),
            AppColors.colorBtnAndCard,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with online indicator
          Stack(
            children: [
              ProfileAvatar(imageUrl: imageUrl, radius: avatarRadius),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.colorBtnAndCard, width: 2),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: size.width * 0.045),
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
