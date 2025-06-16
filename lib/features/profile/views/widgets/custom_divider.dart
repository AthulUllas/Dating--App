import 'package:flutter/material.dart';
import 'package:matrimony/utils/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Colours();
    return Container(
      width: size.width * 0.85,
      height: size.height * 0.0005,
      decoration: BoxDecoration(color: colors.hintColor),
    );
  }
}
