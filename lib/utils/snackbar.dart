import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/fontstyle.dart';

Future<void> snackBar(String message, BuildContext context) async {
  final colors = Colours();
  final fontStyles = Fontstyle();
  showFlash(
    context: context,
    duration: Duration(seconds: 1),
    builder: (context, controller) {
      return FlashBar(
        controller: controller,
        content: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(message),
          ),
        ),
        contentTextStyle: fontStyles.snackBarTextStyle,
        position: FlashPosition.top,
        behavior: FlashBehavior.floating,
        margin: EdgeInsets.only(left: 20, right: 20, top: 24),
        backgroundColor: colors.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
      );
    },
  );
}
