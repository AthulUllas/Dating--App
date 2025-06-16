import 'dart:io';
import 'package:animations/animations.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony/features/auth/service/database_service.dart';
import 'package:matrimony/features/auth/view/widgets/continue_button.dart';
import 'package:matrimony/features/auth/view/widgets/logo_head.dart';
import 'package:matrimony/features/auth/view/widgets/textfield_widget.dart';
import 'package:matrimony/features/userdetails/services/getstorage_service.dart';
import 'package:matrimony/features/userdetails/services/location_service.dart';
import 'package:matrimony/features/userdetails/view/pages/gender_page.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/snackbar.dart';

class UserDetailsPage extends HookWidget {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final colors = Colours();
    final size = MediaQuery.of(context).size;
    final isChecked = useState(false);
    final databaseStorage = DatabaseServices();
    final imageFile = useState<File?>(null);
    Future<void> pickImage() async {
      final imagepicker = ImagePicker();
      final pickedImage = await imagepicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage != null) {
        final file = File(pickedImage.path);
        imageFile.value = file;
        saveDp(file.path);
      }
    }

    Future<String?> getLocation() async {
      final currentLocation = await getCurrentLocation(context);
      return currentLocation;
    }

    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: size.height * 0.15),
            LogoHead(),
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(width: 0.2, color: colors.secondaryColor),
                  image: DecorationImage(
                    image: imageFile.value != null
                        ? FileImage(imageFile.value!)
                        : AssetImage("assets/images/user_logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextfieldWidget(
              trailing: Icon(Clarity.user_line),
              controller: nameController,
              hint: "First Name",
              type: TextInputType.name,
            ),
            SizedBox(height: 3),
            TextfieldWidget(
              trailing: Icon(Clarity.user_line),
              controller: lastNameController,
              hint: "Last Name",
              type: TextInputType.name,
            ),
            SizedBox(height: 3),
            TextfieldWidget(
              trailing: Icon(Clarity.mobile_line),
              controller: phoneController,
              hint: "CountryCode & PhoneNumber",
              type: TextInputType.phone,
            ),
            SizedBox(height: 3),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    "Note : Your photo and details are only visible to you",
                  ),
                ),
              ],
            ),
            SizedBox(height: 1),
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
              onTap: () async {
                if (phoneController.text.length >= 10) {
                  if (isChecked.value) {
                    if (nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty) {
                      final name =
                          nameController.text.trim() +
                          lastNameController.text.trim();
                      saveDetails(name, phoneController.text.trim());
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
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
                      final location = await getLocation();
                      databaseStorage.updateUserDetailsInDatabase(
                        name,
                        phoneController.text.trim(),
                        context,
                        location ?? "No location",
                      );
                      debugPrint(
                        "<_--------------------------Added---------------------------_>",
                      );
                      debugPrint(
                        "<_--------------------------------------------$location----------------------------------------_>",
                      );
                    } else {
                      snackBar(
                        "Textfield empty",
                        context,
                        1,
                        FlashPosition.top,
                      );
                    }
                  } else {
                    snackBar(
                      "Please agree to the terms",
                      context,
                      2,
                      FlashPosition.top,
                    );
                  }
                } else {
                  snackBar(
                    "Enter correct phone number",
                    context,
                    1,
                    FlashPosition.top,
                  );
                }
              },
              child: ContinueButton(),
            ),
            SizedBox(height: size.height * 0.2),
          ],
        ),
      ),
    );
  }
}
