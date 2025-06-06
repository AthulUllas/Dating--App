import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:matrimony/features/splashscreen/helper/checkuserexist_helper.dart';
import 'package:matrimony/utils/colors.dart';

class Splashscreen extends HookWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final size = MediaQuery.of(context).size;

    useEffect(() {
      checkUserExists(context);
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
