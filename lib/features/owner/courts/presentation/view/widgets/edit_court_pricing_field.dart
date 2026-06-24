import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/courts/presentation/view/widgets/shared/section_card.dart';

/// Three pricing input fields: Off-Peak rate, Peak rate, and Membership Discount.
class EditCourtPricingField extends StatelessWidget {
  final TextEditingController offPeakController;
  final TextEditingController peakController;
  final TextEditingController discountController;
  final VoidCallback onChanged;

  const EditCourtPricingField({
    super.key,
    required this.offPeakController,
    required this.peakController,
    required this.discountController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Column(
        children: [
          _PriceInput(
            controller: offPeakController,
            label: 'Off-Peak Hours',
            subtitle: '11 am – 5 pm',
            icon: Icons.wb_sunny_outlined,
            iconColor: Colors.amber.shade300,
            hintText: 'e.g. 300',
            suffixText: 'EGP/hr',
            onChanged: onChanged,
          ),
          const _Divider(),
          _PriceInput(
            controller: peakController,
            label: 'Peak Hours',
            subtitle: '5 pm – 10 pm',
            icon: Icons.nightlight_outlined,
            iconColor: const Color(0xFFB39DDB),
            hintText: 'e.g. 460',
            suffixText: 'EGP/hr',
            onChanged: onChanged,
          ),
          const _Divider(),
          _PriceInput(
            controller: discountController,
            label: 'Membership Discount',
            subtitle: 'For registered members',
            icon: Icons.local_offer_outlined,
            iconColor: AppColors.primaryColor,
            hintText: 'e.g. 15',
            suffixText: '%',
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// ─── Divider ─────────────────────────────────────────────────────────────────

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Divider(color: Colors.white10, height: 1),
      );
}

// ─── Single price input row ──────────────────────────────────────────────────

class _PriceInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final String hintText;
  final String suffixText;
  final VoidCallback onChanged;

  const _PriceInput({
    required this.controller,
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.hintText,
    required this.suffixText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon badge
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),

        // Label + subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),

        // Input field
        SizedBox(
          width: 110,
          child: TextFormField(
            controller: controller,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.right,
            onChanged: (_) => onChanged(),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.25),
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
              suffixText: suffixText,
              suffixStyle: TextStyle(
                color: iconColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: iconColor, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
