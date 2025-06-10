import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

void showOptions(BuildContext context, Widget optionsList) {
  showPopover(context: context, bodyBuilder: (context) => optionsList);
}
