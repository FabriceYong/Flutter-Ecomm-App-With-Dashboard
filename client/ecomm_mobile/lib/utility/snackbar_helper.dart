import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  static void showErrorSnackBar(String message, {String title = 'Error'}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      borderRadius: 20,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      icon: const Icon(
        Icons.error,
        color: Colors.white,
      ),
    );
  }

  static void showSuccessSnackBar(String message, {String title = 'Success'}) {
    Get.snackbar(title, message,
        backgroundColor: Colors.green,
        borderRadius: 20,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
        icon: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ));
  }
}
