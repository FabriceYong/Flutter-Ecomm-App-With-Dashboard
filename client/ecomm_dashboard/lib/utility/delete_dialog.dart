import 'package:ecomm_dashboard/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showDeleteDialog({required
    String title, required Widget content, required Function onPressed}) {
  return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          buttonPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          backgroundColor: bgColor,
          icon: const Icon(
            Icons.warning,
            color: Colors.red,
            size: 30,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: content,
          actions: [
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 2,
                color: secondaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            MaterialButton(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: Colors.red,
              onPressed: () {
                onPressed();
              },
              child: const Text('Delete'),
            )
          ],
        );
      });
}
