import 'package:flutter/material.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/fontstyle.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Fontstyle();
    final colors = Colours();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primaryColor,
        title: Row(
          children: [
            Hero(
              tag: 'splashLogo',
              child: Image.asset("assets/images/matrimony_logo.png", scale: 16),
            ),
            Text("Matrimony", style: textStyle.appBarTitleStyle),
          ],
        ),
        shape: Border(
          bottom: BorderSide(color: colors.secondaryColor, width: 1),
        ),
      ),
    );
  }
}
