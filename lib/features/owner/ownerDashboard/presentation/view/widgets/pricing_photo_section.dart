import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/style.dart';
import 'package:mala3bna/core/widgets/custome_text_field.dart';
import 'package:mala3bna/core/widgets/section_title.dart';

class PricingAndPhotoSection extends StatelessWidget {
  const PricingAndPhotoSection({super.key, required this.priceController});
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Pricing & Photos"),
        CustomTextfield(
          hintText: "Enter price per hour (e.g..200)",
          controller: priceController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Text(
          'Court Photos',
          style: Style.textStyle16Bold.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
