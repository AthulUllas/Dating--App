import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/auth/helper/is_email_helper.dart';
import 'package:matrimony/features/auth/service/database_service.dart';
import 'package:matrimony/features/auth/service/firebase_services.dart';
import 'package:matrimony/features/auth/view/pages/signuppage.dart';
import 'package:matrimony/features/auth/view/widgets/continue_button.dart';
import 'package:matrimony/features/auth/view/widgets/google_signin_button.dart';
import 'package:matrimony/features/auth/view/widgets/logo_head.dart';
import 'package:matrimony/features/auth/view/widgets/textfield_widget.dart';
import 'package:matrimony/features/userdetails/view/pages/userdetails_page.dart';
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
    final databaseServices = DatabaseServices();
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
              type: TextInputType.emailAddress,
            ),
            SizedBox(height: 3),
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
            SizedBox(height: 3),
            GestureDetector(
              onTap: () async {
                final isEmailValid = isValidEmail(
                  signInEmailController.text.trim(),
                );
                if (isEmailValid) {
                  if (signInPasswordController.text.trim().length > 5) {
                    final isSignedIn = authServices.signInUser(
                      signInEmailController.text.trim(),
                      signInPasswordController.text.trim(),
                      context,
                    );
                    if (await isSignedIn) {
                      Navigator.of(context).pushAndRemoveUntil(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  UserDetailsPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return SharedAxisTransition(
                                  animation: animation,
                                  secondaryAnimation: secondaryAnimation,
                                  transitionType:
                                      SharedAxisTransitionType.horizontal,
                                  child: child,
                                );
                              },
                        ),
                        (route) => false,
                      );
                      snackBar("Signed In", context, 1, FlashPosition.bottom);
                    }
                  } else {
                    snackBar(
                      "Password atleast 6 character",
                      context,
                      2,
                      FlashPosition.top,
                    );
                  }
                } else {
                  snackBar(
                    "Enter correct email",
                    context,
                    1,
                    FlashPosition.top,
                  );
                }
              },
              child: ContinueButton(),
            ),
            SizedBox(height: 3),
            GestureDetector(
              onTap: () async {
                final isGoogleSignedIn = await authServices.signInWithGoogle(
                  context,
                );
                if (isGoogleSignedIn) {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          UserDetailsPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            return SharedAxisTransition(
                              animation: animation,
                              secondaryAnimation: secondaryAnimation,
                              transitionType:
                                  SharedAxisTransitionType.horizontal,
                              child: child,
                            );
                          },
                    ),
                  );
                  final user = FirebaseAuth.instance.currentUser;
                  databaseServices.registerUserInDatabase(
                    user!.email,
                    context,
                    user.displayName,
                    user.phoneNumber,
                    null,
                    user.photoURL,
                    "No location",
                  );
                } else {
                  snackBar("Error signing in", context, 2, FlashPosition.top);
                }
                final currentUser = FirebaseAuth.instance.currentUser;
                debugPrint(
                  "<----------------------------------------------------${currentUser?.displayName}--------------------------------->",
                );
                debugPrint(
                  "<-------------------------${currentUser?.photoURL}-------------------->",
                );
                debugPrint(
                  "<---------------------------------------------------------${currentUser?.phoneNumber}------------------------------------------->",
                );
                debugPrint(
                  "<---------------------------${currentUser?.providerData}---------------------------->",
                );
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
                  "Don't have an account?",
                  style: GoogleFonts.mandali(fontSize: size.width * 0.035),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Signuppage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return SharedAxisTransition(
                                animation: animation,
                                secondaryAnimation: secondaryAnimation,
                                transitionType:
                                    SharedAxisTransitionType.horizontal,
                                child: child,
                              );
                            },
                      ),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.mandali(
                      fontSize: size.width * 0.036,
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
