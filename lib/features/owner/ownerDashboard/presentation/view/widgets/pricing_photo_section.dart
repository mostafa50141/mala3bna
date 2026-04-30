import 'package:flutter/material.dart';
import 'package:mala3bna/core/constants/app_colors.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/form_widgets.dart';

class PricingAndPhotoSection extends StatelessWidget {
  const PricingAndPhotoSection({super.key, required this.priceController});
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AddCourtSectionHeader(
          icon: Icons.attach_money_outlined,
          title: 'Pricing & Photos',
        ),
        const SizedBox(height: 12),
        AddCourtTextField(
          controller: priceController,
          hintText: 'Price per hour (e.g. 200)',
          prefixIcon: Icons.payments_outlined,
          keyboardType: TextInputType.number,
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Price is required' : null,
        ),
        const SizedBox(height: 16),

        // "Court Photos" label
        Row(
          children: [
            Icon(Icons.photo_library_outlined,
                color: AppColors.primaryColor, size: 16),
            const SizedBox(width: 6),
            const Text(
              'Court Photos',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
