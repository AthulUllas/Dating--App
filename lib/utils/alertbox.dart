import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

void alerBox(
  BuildContext context,
  Function() onCancel,
  Function() onConfirm,
  String title,
  String message,
) {
  Dialogs.materialDialog(
    context: context,
    title: title,
    msg: message,
    color: Colors.white,
    actionsBuilder: (context) {
      return Row(
        children: [
          IconsOutlineButton(
            onPressed: onCancel,
            text: 'Cancel',
            iconData: Clarity.cancel_line,
          ),
          IconsOutlineButton(
            onPressed: onConfirm,
            text: 'Yes',
            iconData: Icons.done,
          ),
        ],
      );
    },
  );
}
