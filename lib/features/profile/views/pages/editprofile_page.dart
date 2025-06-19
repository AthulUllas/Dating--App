import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/profile/controller/dp_controller.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/fontstyle.dart';

class EditprofilePage extends ConsumerWidget {
  const EditprofilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = Fontstyle();
    final colors = Colours();
    final dpValue = ref.watch(dpProvider);
    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colors.scaffoldBackgroundColor,
        title: Text("Edit profile", style: styles.appBarTitleStyle),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    border: Border.all(width: 1.5, color: colors.primaryColor),
                    image: DecorationImage(
                      image: dpValue.isEmpty
                          ? AssetImage("assets/images/user_logo.png")
                          : FileImage(File(dpValue)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      debugPrint("Tapped...!");
                    },
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: colors.secondaryTextColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(Clarity.edit_solid, size: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
