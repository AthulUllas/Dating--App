import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/profile/controller/dp_controller.dart';
import 'package:matrimony/features/profile/controller/name_controller.dart';
import 'package:matrimony/features/profile/controller/phone_controller.dart';
import 'package:matrimony/utils/colors.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Colours();
    final size = MediaQuery.of(context).size;
    final dpValue = ref.watch(dpProvider);
    final nameValue = ref.watch(nameController);
    final phoneValue = ref.watch(phoneController);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.3,
            decoration: BoxDecoration(color: colors.primaryColor),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, left: 12),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(FontAwesome.left_long_solid),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 1, color: colors.secondaryColor),
                    image: DecorationImage(
                      image: dpValue.isEmpty
                          ? AssetImage("assets/images/user_logo.png")
                          : FileImage(File(dpValue)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  nameValue ?? "No name",
                  style: GoogleFonts.anekDevanagari(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(phoneValue ?? "No number"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
