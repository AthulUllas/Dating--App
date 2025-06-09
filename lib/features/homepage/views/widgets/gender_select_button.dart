import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';

class GenderSelectButton extends StatelessWidget {
  const GenderSelectButton({
    super.key,
    required this.gender,
    required this.color,
  });

  final String gender;
  final Color color;

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
      height: 60,
      child: Center(child: Text(gender, style: GoogleFonts.schibstedGrotesk())),
    );
  }
}
