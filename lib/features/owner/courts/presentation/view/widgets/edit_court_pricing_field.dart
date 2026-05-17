import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/shared/section_card.dart';

/// Pricing input field wrapped in a SectionCard.
class EditCourtPricingField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const EditCourtPricingField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: TextFormField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (_) => onChanged(),
        decoration: InputDecoration(
          hintText: 'Enter hourly rate',
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.3),
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.monetization_on_outlined,
            color: AppColors.primaryColor,
            size: 22,
          ),
          suffixText: 'EGP/hr',
          suffixStyle: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: Colors.white.withValues(alpha: 0.08)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}
