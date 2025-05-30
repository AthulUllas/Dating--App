import 'package:flutter/widgets.dart';
import 'package:matrimony/utils/fontstyle.dart';

class LogoHead extends StatelessWidget {
  const LogoHead({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final styles = Fontstyle();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/matrimony_logo.png",
          width: size.width * 0.2,
        ),
        Text("Matrimony", style: styles.authHeadingStyle),
      ],
    );
  }
}
