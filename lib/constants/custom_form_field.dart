import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool enabled;
  final void Function()? onTap;

  final TextEditingController? controller;

  final String? Function(String?)? validator;
  final String? labelText;

  const CustomTextFormField({
    this.onTap,
    this.enabled = true,
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
      onTap: onTap,
      enabled: enabled,
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
