import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';

/// Individual labeled form fields matching the design.
/// Each field has a colored label above and an icon prefix.
class EditProfileFormSection extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController dobController;
  final TextEditingController bioController;
  final VoidCallback onFieldChanged;
  final VoidCallback onDobTap;

  const EditProfileFormSection({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.dobController,
    required this.bioController,
    required this.onFieldChanged,
    required this.onDobTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name
        _LabeledField(
          label: 'FULL NAME',
          child: _ProfileTextField(
            controller: fullNameController,
            icon: Icons.person_outline,
            hintText: 'Your full name',
            onChanged: (_) => onFieldChanged(),
            validator: (v) => v!.isEmpty ? 'Name is required' : null,
          ),
        ),
        const SizedBox(height: 20),

        // Email Address
        _LabeledField(
          label: 'EMAIL ADDRESS',
          child: _ProfileTextField(
            controller: emailController,
            icon: Icons.email_outlined,
            hintText: 'your@email.com',
            keyboardType: TextInputType.emailAddress,
            onChanged: (_) => onFieldChanged(),
          ),
        ),
        const SizedBox(height: 20),

        // Phone Number
        _LabeledField(
          label: 'PHONE NUMBER',
          child: _ProfileTextField(
            controller: phoneController,
            icon: Icons.phone_outlined,
            hintText: '+20 XXX XXX XXXX',
            keyboardType: TextInputType.phone,
            onChanged: (_) => onFieldChanged(),
            validator: (v) => v!.isEmpty ? 'Phone is required' : null,
          ),
        ),
        const SizedBox(height: 20),

        // Date of Birth
        _LabeledField(
          label: 'DATE OF BIRTH',
          child: GestureDetector(
            onTap: onDobTap,
            child: AbsorbPointer(
              child: _ProfileTextField(
                controller: dobController,
                icon: Icons.calendar_today_outlined,
                hintText: 'YYYY-MM-DD',
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Short Bio
        _LabeledField(
          label: 'SHORT BIO',
          child: _ProfileTextField(
            controller: bioController,
            icon: Icons.description_outlined,
            hintText: 'Tell us about yourself...',
            maxLines: 3,
            onChanged: (_) => onFieldChanged(),
          ),
        ),
      ],
    );
  }
}

// ─── Label ──────────────────────────────────────────────────────────────────

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

// ─── Text Field ─────────────────────────────────────────────────────────────

class _ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const _ProfileTextField({
    required this.controller,
    required this.icon,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white, fontSize: 15),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.25),
          fontSize: 14,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            top: maxLines > 1 ? 14 : 0,
          ),
          child: Icon(icon, color: Colors.white38, size: 20),
        ),
        prefixIconConstraints: maxLines > 1
            ? const BoxConstraints(minWidth: 48, minHeight: 48)
            : null,
        filled: true,
        fillColor: AppColors.colorBtnAndCard,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.07),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}
