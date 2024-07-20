import 'package:flutter/material.dart';
import 'package:get/get.dart';

showMessage(
    {required String message, required String title, required bool isAnError}) {
  Get.snackbar(title, message,
      icon: isAnError ? const Icon(Icons.error) : const Icon(Icons.check),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      margin: const EdgeInsets.only(bottom: 30),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      backgroundColor: isAnError ? Colors.red : Colors.green,
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text('Dismiss'),
      ));
}
