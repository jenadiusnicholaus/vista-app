import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  final String labelText;
  final DateTime? initialDate;
  final void Function(DateTime)? onDateSubmitted;

  const InputTextFormField({
    super.key,
    required this.labelText,
    this.initialDate,
    this.onDateSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return InputDatePickerFormField(
      initialDate: initialDate,
      firstDate: DateTime(1), // Set to the earliest possible date
      lastDate: DateTime(9999),
      keyboardType: TextInputType.datetime,
      onDateSubmitted: onDateSubmitted,
    );
  }
}
