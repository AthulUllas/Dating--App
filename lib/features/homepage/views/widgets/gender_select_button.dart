import 'package:flutter/material.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';

class GenderSelectButton extends StatelessWidget {
  const GenderSelectButton({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    final sides = Dimensions();
    final colors = Colours();
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: colors.homepageGenderButtonColor),
      ),
      margin: sides.primaryPadding,
      height: 55,
      child: Center(child: text),
    );
  }
}
