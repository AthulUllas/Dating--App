import 'package:animations/animations.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/auth/helper/is_email_helper.dart';
import 'package:matrimony/features/auth/service/firebase_services.dart';
import 'package:matrimony/features/auth/view/pages/signin_page.dart';
import 'package:matrimony/features/auth/view/widgets/continue_button.dart';
import 'package:matrimony/features/auth/view/widgets/google_signin_button.dart';
import 'package:matrimony/features/auth/view/widgets/logo_head.dart';
import 'package:matrimony/features/auth/view/widgets/textfield_widget.dart';
import 'package:matrimony/features/homepage/views/pages/homepage.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';
import 'package:matrimony/utils/fontstyle.dart';
import 'package:matrimony/utils/snackbar.dart';

class Signuppage extends HookWidget {
  const Signuppage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final size = MediaQuery.of(context).size;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final sides = Dimensions();
    final authServices = FirebaseServices();
    final isVisible = useState(false);
    final styles = Fontstyle();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up", style: styles.appBarTitleStyle),
        centerTitle: true,
        backgroundColor: colors.scaffoldBackgroundColor,
        shape: Border(
          bottom: BorderSide(color: colors.textFieldLabelColor, width: 0.3),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Clarity.close_line),
          ),
        ),
      ),
      backgroundColor: colors.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: size.height * 0.1),
            LogoHead(),
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
                final isEmailValid = isValidEmail(emailController.text.trim());
                if (isEmailValid) {
                  if (passwordController.text.trim().length > 5) {
                    final isUserCreated = authServices.createUser(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      context,
                    );
                    if (await isUserCreated) {
                      Navigator.of(context).pushAndRemoveUntil(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  SigninPage(),
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
                    }
                  } else {
                    snackBar(
                      "Password atleast 6 characters",
                      context,
                      2,
                      FlashPosition.top,
                    );
                  }
                } else {
                  snackBar(
                    "Enter the correct email",
                    context,
                    2,
                    FlashPosition.top,
                  );
                }
              },
              child: ContinueButton(),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                final isSignedIn = await authServices.signInWithGoogle(context);
                if (isSignedIn) {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Homepage(),
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
                } else {
                  snackBar("Login failed", context, 1, FlashPosition.top);
                }
              },
              child: GoogleSigninButton(),
            ),
            SizedBox(height: size.height * 0.3),
          ],
        ),
      ),
    );
  }
}
