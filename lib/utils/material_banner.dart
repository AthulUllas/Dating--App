import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony/utils/colors.dart';

void banner(String message, BuildContext context, int duration) {
  final colors = Colours();
  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      content: Text(message),
      contentTextStyle: GoogleFonts.anekDevanagari(
        color: colors.primaryTextColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: Text("Dismiss"),
        ),
      ],
      backgroundColor: colors.secondaryColor,
    ),
  );
  Future.delayed(Duration(seconds: duration), () {
    hideBanner(context);
  });
}

void hideBanner(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
}
