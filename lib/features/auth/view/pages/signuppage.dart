import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/auth/helper/is_email_helper.dart';
import 'package:matrimony/features/auth/service/firebase_services.dart';
import 'package:matrimony/features/auth/view/pages/signin_page.dart';
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
    final isVisible = useState(false);
    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: size.height * 0.2),
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
            SizedBox(height: 10),
            TextfieldWidget(
              trailing: Icon(Clarity.email_line),
              controller: emailController,
              hint: "E-mail",
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: colors.secondaryColor, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 60,
              margin: sides.primaryPadding,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Icon(Clarity.lock_line),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      obscureText: isVisible.value ? false : true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(color: colors.hintColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: IconButton(
                      onPressed: () {
                        isVisible.value = !isVisible.value;
                      },
                      icon: isVisible.value
                          ? Icon(Clarity.eye_hide_line)
                          : Icon(Clarity.eye_line),
                    ),
                  ),
                ],
              ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SigninPage()),
                      );
                    } else {
                      authServices.createUser(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                        context,
                      );
                    }
                  } else {
                    snackBar("Password empty", context, 2);
                  }
                } else {
                  snackBar("Enter the correct email", context, 2);
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
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                authServices.signInWithGoogle(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: colors.secondaryColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                margin: sides.primaryPadding,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Brand(Brands.google, size: 28),
                      SizedBox(width: 10),
                      Text("Google", style: styles.googleButtonTextStyle),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.25),
          ],
        ),
      ),
    );
  }
}
