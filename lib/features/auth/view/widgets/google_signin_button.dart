import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';
import 'package:matrimony/utils/fontstyle.dart';

class GoogleSigninButton extends StatelessWidget {
  const GoogleSigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final sides = Dimensions();
    final styles = Fontstyle();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: colors.secondaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      margin: sides.primaryPadding,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Brand(Brands.google, size: 28),
            SizedBox(width: 10),
            Text("Google", style: styles.googleButtonTextStyle),
          ],
        ),
      ),
    );
  }
}
