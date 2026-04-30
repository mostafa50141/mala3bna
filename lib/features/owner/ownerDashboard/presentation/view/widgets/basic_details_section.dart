import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/dropdown_btn_field.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/form_widgets.dart';

class BasicDetailsSection extends StatelessWidget {
  final TextEditingController nameController;
  const BasicDetailsSection({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AddCourtSectionHeader(
          icon: Icons.sports_soccer_outlined,
          title: 'Basic Details',
        ),
        const SizedBox(height: 12),
        AddCourtTextField(
          controller: nameController,
          hintText: "Enter your court's name",
          prefixIcon: Icons.stadium_outlined,
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Court name is required' : null,
        ),
        const SizedBox(height: 12),
        DropdownBtnField(),
      ],
    );
  }
}
