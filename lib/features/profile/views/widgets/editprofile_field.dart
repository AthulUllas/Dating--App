import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';
import 'package:matrimony/utils/fontstyle.dart';

class EditprofileField extends StatelessWidget {
  const EditprofileField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.type,
    required this.field,
    required this.leading,
    this.trailing,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType type;
  final String field;
  final IconData leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final sides = Dimensions();
    final size = MediaQuery.of(context).size;
    final colors = Colours();
    final styles = Fontstyle();
    return Container(
      margin: sides.editProfilePadding,
      height: size.height * 0.08,
      decoration: BoxDecoration(
        color: colors.secondaryTextColor,
        border: Border.all(color: colors.primaryColor, width: 0.1),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8),
                child: Text(field, style: styles.editProfileTextStyle),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Icon(leading, size: 22),
              ),
              SizedBox(width: 18),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: type,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(color: colors.hintColor),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: trailing ?? Icon(Clarity.pencil_line, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
