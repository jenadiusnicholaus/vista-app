import 'package:flutter/material.dart';

class CustomTextFormFied extends StatelessWidget {
  final Widget? suffixIcon;
  final bool? obscureText;

  final String? Function(String?)? validator;
  final String? labelText;

  const CustomTextFormFied({
    super.key,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
