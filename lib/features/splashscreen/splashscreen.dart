import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:matrimony/features/auth/view/pages/signin_page.dart';
import 'package:matrimony/features/homepage/views/pages/homepage.dart';
import 'package:matrimony/utils/colors.dart';

class Splashscreen extends HookWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final size = MediaQuery.of(context).size;

    useEffect(() {
      final isLoggedIn = useState(
        (FirebaseAuth.instance.currentUser != null) ? true : false,
      );
      Timer(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                isLoggedIn.value ? Homepage() : SigninPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  final tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: Curves.easeInOut));
                  final offSetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offSetAnimation,
                    child: child,
                  );
                },
          ),
        );
      });
      return null;
    });

    return Scaffold(
      backgroundColor: colors.splashBackgroudColor,
      body: Center(
        child: Image.asset(
          "assets/images/matrimony_logo.png",
          width: size.width * 0.5,
          height: size.height * 0.5,
        ),
      ),
    );
  }
}
