import 'package:animations/animations.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/auth/view/widgets/continue_button.dart';
import 'package:matrimony/features/auth/view/widgets/logo_head.dart';
import 'package:matrimony/features/auth/view/widgets/textfield_widget.dart';
import 'package:matrimony/features/userdetails/services/getstorage_service.dart';
import 'package:matrimony/features/userdetails/view/pages/gender_page.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/snackbar.dart';

class UserDetailsPage extends HookWidget {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final colors = Colours();
    final size = MediaQuery.of(context).size;
    final isChecked = useState(false);
    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: size.height * 0.2),
            LogoHead(),
            TextfieldWidget(
              trailing: Icon(Clarity.user_line),
              controller: nameController,
              hint: "Name",
              type: TextInputType.name,
            ),
            TextfieldWidget(
              trailing: Icon(Clarity.mobile_line),
              controller: phoneController,
              hint: "Phone",
              type: TextInputType.phone,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text("Note : Your details are only visible to you"),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: CupertinoCheckbox(
                    value: isChecked.value,
                    onChanged: (value) {
                      isChecked.value = !isChecked.value;
                    },
                  ),
                ),
                Text(
                  "By clicking this you are agreeing to the terms and conditions",
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (isChecked.value) {
                  if (nameController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty) {
                    saveDetails(
                      nameController.text.trim(),
                      phoneController.text.trim(),
                    );
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            GenderPage(),
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
                    snackBar("Textfield empty", context, 1, FlashPosition.top);
                  }
                } else {
                  snackBar(
                    "Please agree to the terms",
                    context,
                    2,
                    FlashPosition.top,
                  );
                }
              },
              child: ContinueButton(),
            ),
            SizedBox(height: size.height * 0.3),
          ],
        ),
      ),
    );
  }
}
