import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/form_widgets.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key, required this.addressController});
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddCourtSectionHeader(
          icon: Icons.location_on_outlined,
          title: 'Location'.tr,
        ),
        const SizedBox(height: 12),
        AddCourtTextField(
          controller: addressController,
          hintText: "Enter your court's address".tr,
          prefixIcon: Icons.map_outlined,
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Address is required'.tr : null,
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
