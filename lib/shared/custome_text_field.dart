import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.width,
    this.height,
    this.fillcolor,
  });
  final Function(String)? onChanged;
  final String? hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final double? width;
  final double? height;
  final Color? fillcolor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
      child: SizedBox(
        width: width,
        height: height,
        child: TextFormField(
          validator: validator,
          onChanged: onChanged,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: fillcolor,
            hintStyle: const TextStyle(color: Colors.white70),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              // borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              // borderSide: const BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
