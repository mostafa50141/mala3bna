import 'package:flutter/material.dart';
import 'package:mala3bna/core/widgets/custome_text_field.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key, required this.controller, this.hintText});

  final TextEditingController controller;
  final String? hintText;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextfield(
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "⚠️ Please enter a password";
        } else if (value.length < 6) {
          return "⚠️ Password must be at least 6 characters";
        }
        return null;
      },
      hintText: widget.hintText ?? "Password",
      obscureText: isObscure,
      width: double.infinity,
      fillcolor: const Color(0xFF2C3617).withOpacity(0.3),
      suffixIcon: IconButton(
        icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
        color: Colors.white70,
        onPressed: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
      ),
    );
  }
}
