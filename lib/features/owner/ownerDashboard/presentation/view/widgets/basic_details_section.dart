import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custome_text_field.dart';
import 'package:mala3bna/core/widgets/section_title.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dropdown_btn_field.dart';

class BasicDetailsSection extends StatelessWidget {
  final TextEditingController nameController;
  const BasicDetailsSection({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Basic Details"),
        CustomTextfield(
          hintText: "Enter your court's name",
          controller: nameController,
        ),
        const SizedBox(height: 8),
        DropdownBtnField(),
      ],
    );
  }
}
