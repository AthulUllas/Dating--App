import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/auth/view/widgets/continue_button.dart';
import 'package:matrimony/features/userdetails/view/widgets/gender_button.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/fontstyle.dart';

class GenderPage extends HookWidget {
  const GenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final styles = Fontstyle();
    final size = MediaQuery.of(context).size;
    final isMaleTapped = useState(false);
    final isFemaleTapped = useState(false);
    final isOtherTapped = useState(false);
    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: size.height * 0.2),
            Text(
              "Please select your Gender",
              style: GoogleFonts.aBeeZee(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            GestureDetector(
              onTap: () {
                isMaleTapped.value = true;
              },
              child: GenderButton(
                icon: Icon(MingCute.male_line),
                text: Text("Male", style: styles.genderButtonTextStyle),
                color: isMaleTapped.value
                    ? colors.primaryColor
                    : colors.buttonBorderColor,
                width: isMaleTapped.value ? 1 : 0.3,
              ),
            ),
            GestureDetector(
              onTap: () {
                isFemaleTapped.value = true;
              },
              child: GenderButton(
                icon: Icon(MingCute.female_line),
                text: Text("Female", style: styles.genderButtonTextStyle),
                color: isFemaleTapped.value
                    ? colors.primaryColor
                    : colors.buttonBorderColor,
                width: isFemaleTapped.value ? 1 : 0.3,
              ),
            ),
            GestureDetector(
              onTap: () {
                isOtherTapped.value = false;
              },
              child: GenderButton(
                icon: Icon(FontAwesome.rainbow_solid, size: 18),
                text: Text("Other", style: styles.genderButtonTextStyle),
                color: isOtherTapped.value
                    ? colors.primaryColor
                    : colors.buttonBorderColor,
                width: isOtherTapped.value ? 1 : 0.3,
              ),
            ),
            ContinueButton(),
            SizedBox(height: size.height * 0.2),
          ],
        ),
      ),
    );
  }
}
