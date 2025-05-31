import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fontstyle {
  final appBarTitleStyle = GoogleFonts.macondo(
    textStyle: TextStyle(fontSize: 22),
  );

  final authHeadingStyle = GoogleFonts.macondo(
    textStyle: TextStyle(fontSize: 28),
  );

  final buttonTextStyle = GoogleFonts.mandali(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );

  final googleButtonTextStyle = GoogleFonts.mandali(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

  final snackBarTextStyle = GoogleFonts.mandali(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  final genderButtonTextStyle = GoogleFonts.mandali(
    fontWeight: FontWeight.bold,
  );
}
