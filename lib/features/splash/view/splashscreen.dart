import 'package:flutter/material.dart';
import 'package:matrimony/features/splash/helper/checkuserexist_helper.dart';
import 'package:matrimony/utils/colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    checkUserExists(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final size = MediaQuery.of(context).size;

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
