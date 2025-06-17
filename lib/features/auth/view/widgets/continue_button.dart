import 'package:flutter/widgets.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';
import 'package:matrimony/utils/fontstyle.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final sides = Dimensions();
    final styles = Fontstyle();
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: colors.buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: sides.primaryPadding,
      height: size.height * 0.045,
      child: Center(child: Text("Continue", style: styles.buttonTextStyle)),
    );
  }
}
