import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/auth/service/database_service.dart';
import 'package:matrimony/features/auth/view/widgets/continue_button.dart';
import 'package:matrimony/features/userdetails/services/getstorage_service.dart';
import 'package:matrimony/features/userdetails/view/widgets/gender_button.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/fontstyle.dart';
import 'package:matrimony/utils/snackbar.dart';

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
    final databaseServices = DatabaseServices();
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
                isFemaleTapped.value
                    ? isFemaleTapped.value = false
                    : isFemaleTapped.value = isFemaleTapped.value;
                isOtherTapped.value
                    ? isOtherTapped.value = false
                    : isOtherTapped.value = isOtherTapped.value;
              },
              child: GenderButton(
                icon: Icon(
                  MingCute.male_line,
                  color: isMaleTapped.value
                      ? colors.primaryColor
                      : colors.buttonBorderColor,
                ),
                text: Text("Male", style: styles.genderButtonTextStyle),
                color: isMaleTapped.value
                    ? colors.primaryColor
                    : colors.buttonBorderColor,
                width: isMaleTapped.value ? 2 : 0.3,
              ),
            ),
            GestureDetector(
              onTap: () {
                isFemaleTapped.value = true;
                isMaleTapped.value
                    ? isMaleTapped.value = false
                    : isMaleTapped.value = isMaleTapped.value;
                isOtherTapped.value
                    ? isOtherTapped.value = false
                    : isOtherTapped.value = isOtherTapped.value;
              },
              child: GenderButton(
                icon: Icon(
                  MingCute.female_line,
                  color: isFemaleTapped.value
                      ? colors.primaryColor
                      : colors.buttonBorderColor,
                ),
                text: Text("Female", style: styles.genderButtonTextStyle),
                color: isFemaleTapped.value
                    ? colors.primaryColor
                    : colors.buttonBorderColor,
                width: isFemaleTapped.value ? 2 : 0.3,
              ),
            ),
            GestureDetector(
              onTap: () {
                isOtherTapped.value = true;
                isMaleTapped.value
                    ? isMaleTapped.value = false
                    : isMaleTapped.value = isMaleTapped.value;
                isFemaleTapped.value
                    ? isFemaleTapped.value = false
                    : isFemaleTapped.value = isFemaleTapped.value;
              },
              child: GenderButton(
                icon: Icon(
                  FontAwesome.rainbow_solid,
                  size: 18,
                  color: isOtherTapped.value
                      ? colors.primaryColor
                      : colors.buttonBorderColor,
                ),
                text: Text("Other", style: styles.genderButtonTextStyle),
                color: isOtherTapped.value
                    ? colors.primaryColor
                    : colors.buttonBorderColor,
                width: isOtherTapped.value ? 2 : 0.3,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!isMaleTapped.value &&
                    !isFemaleTapped.value &&
                    !isOtherTapped.value) {
                  snackBar("Are you gay/les", context, 2, FlashPosition.top);
                } else {
                  String? gender;
                  if (isMaleTapped.value) {
                    gender = "Male";
                  }
                  if (isFemaleTapped.value) {
                    gender = "Female";
                  }
                  if (isOtherTapped.value) {
                    gender = "Other";
                  }
                  saveGender(gender);
                  databaseServices.updateGenderInDatabase(
                    gender.toString(),
                    context,
                  );
                }
              },
              child: ContinueButton(),
            ),
            SizedBox(height: size.height * 0.2),
          ],
        ),
      ),
    );
  }
}
