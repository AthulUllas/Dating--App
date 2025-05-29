import 'package:flutter/material.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';
import 'package:matrimony/utils/fontstyle.dart';

class Signuppage extends StatelessWidget {
  const Signuppage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final styles = Fontstyle();
    final size = MediaQuery.of(context).size;
    final sides = Dimensions();
    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/matrimony_logo.png",
                  width: size.width * 0.2,
                ),
                Text("Matrimony", style: styles.authHeadingStyle),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: colors.secondaryColor, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 60,
              margin: sides.primaryPadding,
            ),
          ],
        ),
      ),
    );
  }
}
