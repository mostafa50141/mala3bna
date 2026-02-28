import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/info_chip.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({
    super.key,
    required this.username,
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.onEditPressed,
  });

  final String username;
  final String fullName;
  final String birthDate;
  final String gender;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Username
        Text(
          '@$username',
          style: Style.textStyle14Bold.copyWith(color: AppColors.primaryColor),
        ),

        SizedBox(height: size.height * 0.006),

        Text(
          fullName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Style.textStyle20Bold,
        ),

        SizedBox(height: size.height * 0.01),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            InfoChip(icon: Icons.calendar_today_outlined, label: birthDate),
            InfoChip(icon: Icons.male, label: gender),
          ],
        ),
        SizedBox(height: size.height * 0.015),

        SizedBox(
          height: 38,
          child: OutlinedButton.icon(
            onPressed: onEditPressed,
            icon: const Icon(Icons.edit_note_outlined, size: 20),
            label: const Text("Edit Profile"),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: BorderSide(color: AppColors.primaryColor, width: .5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
