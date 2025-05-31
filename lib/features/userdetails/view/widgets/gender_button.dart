import 'package:flutter/material.dart';
import 'package:matrimony/utils/colors.dart';

class GenderButton extends StatelessWidget {
  const GenderButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.width,
  });

  final Widget icon;
  final Widget text;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(width: width, color: color),
      ),
      height: 40,
      width: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [icon, SizedBox(width: 20), text],
      ),
    );
  }
}
