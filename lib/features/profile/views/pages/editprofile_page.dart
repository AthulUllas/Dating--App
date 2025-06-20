import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony/features/home/service/database_service.dart';
import 'package:matrimony/features/profile/controller/dp_controller.dart';
import 'package:matrimony/features/profile/views/widgets/editprofile_field.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';
import 'package:matrimony/utils/fontstyle.dart';

class EditprofilePage extends HookConsumerWidget {
  const EditprofilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = Fontstyle();
    final colors = Colours();
    final dpValue = ref.watch(dpProvider);
    final imageFile = useState<File?>(null);
    final databaseFieldServices = DatabaseFieldServices();
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final sides = Dimensions();
    final size = MediaQuery.of(context).size;
    Future<void> pickImage() async {
      final imagepicker = ImagePicker();
      final pickedImage = await imagepicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedImage != null) {
        final file = File(pickedImage.path);
        imageFile.value = file;
      }
    }

    final List<String> genderList = ['Male', 'Female', 'Other'];
    final selectedGender = useState('Male');

    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colors.scaffoldBackgroundColor,
        title: Text("Edit profile", style: styles.appBarTitleStyle),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: size.height * 0.1),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  border: Border.all(width: 1.5, color: colors.primaryColor),
                  image: DecorationImage(
                    image: imageFile.value != null
                        ? FileImage(imageFile.value!)
                        : dpValue.isEmpty
                        ? AssetImage("assets/images/user_logo.png")
                        : FileImage(File(dpValue)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
              ),
              IconButton(
                onPressed: () {
                  pickImage();
                },
                icon: Icon(Clarity.camera_line, color: Colors.white, size: 32),
              ),
            ],
          ),
          Text("Profile Photo", style: styles.editProfileTextStyle),
          SizedBox(height: size.height * 0.05),
          FutureBuilder(
            future: databaseFieldServices.getUserField(currentUserUid, 'name'),
            builder: (context, snapshot) {
              final name = snapshot.data;
              return EditprofileField(
                controller: nameController,
                type: TextInputType.name,
                hintText: name ?? "Name",
                field: "Full Name",
                leading: Clarity.user_line,
              );
            },
          ),
          SizedBox(height: 3),
          FutureBuilder(
            future: databaseFieldServices.getUserField(currentUserUid, 'phone'),
            builder: (context, snapshot) {
              final phone = snapshot.data;
              return EditprofileField(
                hintText: phone ?? "Phone",
                controller: phoneController,
                type: TextInputType.phone,
                field: "Phone number",
                leading: Clarity.phone_handset_line,
              );
            },
          ),
          SizedBox(height: 3),
          FutureBuilder(
            future: databaseFieldServices.getUserField(currentUserUid, 'email'),
            builder: (context, snapshot) {
              final email = snapshot.data;
              return EditprofileField(
                hintText: email ?? "E-mail",
                controller: emailController,
                type: TextInputType.emailAddress,
                field: "E-mail",
                leading: Clarity.email_line,
                trailing: GestureDetector(
                  onTap: () {
                    debugPrint("Tappedd");
                  },
                  child: Icon(Icons.done, size: 22),
                ),
              );
            },
          ),
          SizedBox(height: 3),
          Container(
            margin: sides.editProfilePadding,
            height: size.height * 0.1,
            decoration: BoxDecoration(
              color: colors.secondaryTextColor,
              border: Border.all(color: colors.primaryColor, width: 0.1),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8),
                      child: Text("Gender", style: styles.editProfileTextStyle),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Icon(Bootstrap.rainbow),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Select gender",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16,
                          ),
                        ),
                        value: selectedGender.value,
                        items: genderList.map((gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          selectedGender.value = newValue!;
                        },
                      ),
                    ),
                    SizedBox(width: size.width * 0.04),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.2),
        ],
      ),
    );
  }
}
