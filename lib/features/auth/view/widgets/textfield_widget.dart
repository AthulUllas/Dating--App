import 'package:flutter/material.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    super.key,
    required this.trailing,
    required this.controller,
    required this.hint,
    required this.type,
  });

  final Widget trailing;
  final TextEditingController controller;
  final String hint;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final sides = Dimensions();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.secondaryColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 60,
      margin: sides.primaryPadding,
      child: Row(
        children: [
          Padding(padding: const EdgeInsets.only(left: 16.0), child: trailing),
          SizedBox(width: 20),
          Expanded(
            child: TextField(
              keyboardType: type,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: colors.hintColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
