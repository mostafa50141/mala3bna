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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '@$username',
          style: Style.textStyle14Bold
              .copyWith(color: AppColors.primaryColor, letterSpacing: 0.3),
        ),
        const SizedBox(height: 4),
        Text(
          fullName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Style.textStyle20Bold,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            InfoChip(icon: Icons.calendar_today_outlined, label: birthDate),
            InfoChip(icon: Icons.person_outline, label: gender),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 36,
          child: OutlinedButton.icon(
            onPressed: onEditPressed,
            icon: const Icon(Icons.edit_note_outlined, size: 18),
            label: const Text('Edit Profile',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(
                  color: AppColors.primaryColor.withValues(alpha: 0.7),
                  width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
            ),
          ),
        ),
      ],
    );
  }
}
