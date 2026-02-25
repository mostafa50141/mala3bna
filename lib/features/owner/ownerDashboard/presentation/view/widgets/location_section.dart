import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custome_text_field.dart';
import 'package:mala3bna/core/widgets/section_title.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key, required this.addressController});
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Location"),
        CustomTextfield(
          hintText: "Enter your court's address",
          controller: addressController,
        ),
        const SizedBox(height: 16),

        /// Map Placeholder
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade800,
          ),
          child: const Center(
            child: Icon(Icons.location_on, color: Colors.greenAccent),
          ),
        ),
      ],
    );
  }
}
