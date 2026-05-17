import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/form_widgets.dart';
import 'package:mala3bna/features/owner/setting/presentation/view/widgets/edit_profile_gender_selector.dart';

/// Personal information form card with all profile fields.
class EditProfileFormSection extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final TextEditingController birthDateController;
  final String genderValue;
  final ValueChanged<String> onGenderChanged;
  final VoidCallback onFieldChanged;

  const EditProfileFormSection({
    super.key,
    required this.fullNameController,
    required this.usernameController,
    required this.phoneController,
    required this.birthDateController,
    required this.genderValue,
    required this.onGenderChanged,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        _SectionHeader(title: 'Personal Information'),
        const SizedBox(height: 14),

        // Fields card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.colorBtnAndCard.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          child: Column(
            children: [
              AddCourtTextField(
                controller: fullNameController,
                hintText: 'Full Name',
                prefixIcon: Icons.person_outline,
                validator: (v) =>
                    v!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 16),
              AddCourtTextField(
                controller: usernameController,
                hintText: 'Username',
                prefixIcon: Icons.alternate_email,
                validator: (v) =>
                    v!.isEmpty ? 'Please enter username' : null,
              ),
              const SizedBox(height: 16),
              AddCourtTextField(
                controller: phoneController,
                hintText: 'Phone Number',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v!.isEmpty ? 'Please enter phone number' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: AddCourtTextField(
                      controller: birthDateController,
                      hintText: 'Birth Date',
                      prefixIcon: Icons.calendar_today_outlined,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: EditProfileGenderSelector(
                      value: genderValue,
                      onChanged: onGenderChanged,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Section Header ─────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: Style.textStyle16Bold.copyWith(
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
