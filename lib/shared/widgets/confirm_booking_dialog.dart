import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final bool isMobileMoneySelected;
  final dynamic id;
  final String selectedPaymentMethod;
  final String selectedAcconntNumber;
  final String amount;
  final void Function()? onPressed;

  const ConfirmDialog({
    super.key,
    required this.isMobileMoneySelected,
    required this.id,
    required this.selectedPaymentMethod,
    required this.selectedAcconntNumber,
    required this.amount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Request"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Request ID: $id"),
          Text("Payment Method: $selectedPaymentMethod"),
          Text("Account Number: $selectedAcconntNumber"),
          Text("Amount: $amount"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text("Confirm"),
        ),
      ],
    );
  }
}
