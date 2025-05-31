import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/auth/helper/is_email_helper.dart';
import 'package:matrimony/features/auth/service/firebase_services.dart';
import 'package:matrimony/features/auth/view/pages/signuppage.dart';
import 'package:matrimony/features/auth/view/widgets/continue_button.dart';
import 'package:matrimony/features/auth/view/widgets/google_signin_button.dart';
import 'package:matrimony/features/auth/view/widgets/logo_head.dart';
import 'package:matrimony/features/auth/view/widgets/textfield_widget.dart';
import 'package:matrimony/features/homepage/views/pages/homepage.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';
import 'package:matrimony/utils/fontstyle.dart';
import 'package:matrimony/utils/snackbar.dart';

class SigninPage extends HookWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final styles = Fontstyle();
    final signInEmailController = useTextEditingController();
    final signInPasswordController = useTextEditingController();
    final isVisible = useState(false);
    final sides = Dimensions();
    final size = MediaQuery.of(context).size;
    final authServices = FirebaseServices();
    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Sign In", style: styles.appBarTitleStyle),
        centerTitle: true,
        backgroundColor: colors.scaffoldBackgroundColor,
        shape: Border(
          bottom: BorderSide(color: colors.textFieldLabelColor, width: 0.3),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: size.height * 0.1),
            LogoHead(),
            TextfieldWidget(
              trailing: Icon(Clarity.email_line),
              controller: signInEmailController,
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
                      controller: signInPasswordController,
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
                final isEmailValid = isValidEmail(signInEmailController.text);
                if (isEmailValid) {
                  if (signInPasswordController.text.trim().length > 5) {
                    final isSignedIn = authServices.signInUser(
                      signInEmailController.text.trim(),
                      signInPasswordController.text.trim(),
                      context,
                    );
                    if (await isSignedIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Homepage()),
                      );
                      snackBar("Signed In", context, 1);
                    }
                  } else {
                    snackBar("Password atleast 6 character", context, 2);
                  }
                } else {
                  snackBar("Enter correct email", context, 1);
                }
              },
              child: ContinueButton(),
            ),
            GestureDetector(
              onTap: () async {
                final isGoogleSignedIn = await authServices.signInWithGoogle(
                  context,
                );
                if (isGoogleSignedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Homepage()),
                  );
                } else {
                  snackBar("Error signing in", context, 2);
                }
              },
              child: GoogleSigninButton(),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account,",
                  style: GoogleFonts.mandali(fontSize: 16),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Signuppage()),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.mandali(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.23),
          ],
        ),
      ),
    );
  }
}
