import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.obscureText = false,
      required this.label,
      this.validator,
      this.maxLines = 1});
  final TextEditingController controller;
  final bool obscureText;
  final String label;
  final String? Function(String?)? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
    );
  }
}
