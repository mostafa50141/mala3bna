import 'package:flutter/material.dart';
import 'package:mala3bna/features/owner/ownerDashboard/presentation/view/widgets/form_widgets.dart';

/// Thin wrapper around [AddCourtTextField] that provides consistent
/// form-field styling for the Edit Profile screen.
class EditProfileFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const EditProfileFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AddCourtTextField(
      controller: controller,
      hintText: hint,
      prefixIcon: icon,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
