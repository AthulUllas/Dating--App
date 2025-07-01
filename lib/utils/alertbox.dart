import 'package:animated_confirm_dialog/animated_confirm_dialog.dart';
import 'package:flutter/material.dart';

void alerBox(
  BuildContext context,
  Function() onCancel,
  Function() onConfirm,
  String title,
  String message,
) {
  showCustomDialog(
    context: context,
    onCancel: onCancel,
    onConfirm: onConfirm,
    title: title,
    message: message,
    cancelButtonText: 'No',
    confirmButtonText: 'Yes',
    cancelButtonColor: Colors.red,
  );
}
