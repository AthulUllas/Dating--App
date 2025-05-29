import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/auth/helper/is_email_helper.dart';
import 'package:matrimony/features/auth/service/firebase_services.dart';
import 'package:matrimony/features/auth/view/widgets/textfield_widget.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';
import 'package:matrimony/utils/fontstyle.dart';
import 'package:matrimony/utils/snackbar.dart';

class Signuppage extends HookWidget {
  const Signuppage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final styles = Fontstyle();
    final size = MediaQuery.of(context).size;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final sides = Dimensions();
    final authServices = FirebaseServices();
    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/matrimony_logo.png",
                  width: size.width * 0.2,
                ),
                Text("Matrimony", style: styles.authHeadingStyle),
              ],
            ),
            TextfieldWidget(
              trailing: Icon(Clarity.email_line),
              controller: emailController,
              hint: "E-mail",
            ),
            TextfieldWidget(
              trailing: Icon(Clarity.lock_line),
              controller: passwordController,
              hint: "Password",
            ),
            GestureDetector(
              onTap: () async {
                final isEmailValid = isValidEmail(emailController.text);
                if (isEmailValid) {
                  if (passwordController.text.isNotEmpty) {
                    await FirebaseAuth.instance.currentUser?.reload();
                    bool isVerified =
                        FirebaseAuth.instance.currentUser?.emailVerified ??
                        false;
                    if (isVerified) {
                      debugPrint(
                        "<----------------------------Verified--------------------------->",
                      );
                      emailController.clear();
                      passwordController.clear();
                    } else {
                      authServices.createUser(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        context,
                      );
                    }
                  } else {
                    snackBar("Password empty", context);
                  }
                } else {
                  snackBar("Enter the correct email", context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: colors.buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: sides.primaryPadding,
                height: 50,
                child: Center(
                  child: Text("Continue", style: styles.buttonTextStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
