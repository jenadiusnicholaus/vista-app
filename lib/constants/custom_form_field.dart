import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController? controller;

  final String? Function(String?)? validator;
  final String? labelText;

  const CustomTextFormField({
    super.key,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.labelText,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      obscureText: obscureText ?? false,

      // sufxicon
    );
  }
}
