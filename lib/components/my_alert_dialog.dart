import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onDelete;
  final String confirmString;
  final String cancelString;

  const MyAlertDialog(
      {Key? key,
        required this.title,
        this.cancelString = 'Cancel',
        this.confirmString = 'Confirm',
        required this.content,
        required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title.tr),
      content: Text(content.tr),
      actions: [
        TextButton(
            onPressed:
                () => Get.back(),
            child:
            Text(cancelString.tr)),
        TextButton(
            onPressed:
                () {
              onDelete();
              Get.back();
            },
            child:
            Text(confirmString.tr)),
      ],
    );
  }
}