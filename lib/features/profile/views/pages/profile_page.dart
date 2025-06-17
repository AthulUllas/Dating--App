import 'dart:io';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:matrimony/features/auth/service/firebase_services.dart';
import 'package:matrimony/features/auth/view/pages/signin_page.dart';
import 'package:matrimony/features/profile/controller/dp_controller.dart';
import 'package:matrimony/features/profile/controller/name_controller.dart';
import 'package:matrimony/features/profile/controller/phone_controller.dart';
import 'package:matrimony/features/profile/views/widgets/custom_divider.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Colours();
    final dpValue = ref.watch(dpProvider);
    final nameValue = ref.watch(nameController);
    final phoneValue = ref.watch(phoneController);
    final dpNotifier = ref.read(dpProvider.notifier);
    final nameNotifier = ref.read(nameController.notifier);
    final phoneNotifier = ref.read(phoneController.notifier);
    final size = MediaQuery.of(context).size;
    final sides = Dimensions();
    final authServices = FirebaseServices();
    final refreshController = RefreshController();
    Future<void> onRefresh() async {
      await Future.delayed(Duration(seconds: 1));
      dpNotifier.refresh();
      nameNotifier.refresh();
      phoneNotifier.refresh();
      refreshController.refreshCompleted();
    }

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: onRefresh,
        physics: ScrollPhysics(),
        header: CustomHeader(
          height: 35,
          completeDuration: Duration(milliseconds: 1),
          builder: (context, mode) {
            Widget body;
            if (mode == RefreshStatus.idle) {
              body = Text("Pull down to refresh");
            } else if (mode == RefreshStatus.refreshing) {
              body = LoadingAnimationWidget.staggeredDotsWave(
                color: colors.primaryTextColor,
                size: 30,
              );
            } else {
              body = SizedBox.shrink();
            }
            return Center(child: body);
          },
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 1.5, color: colors.primaryColor),
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
              textAlign: TextAlign.center,
              style: GoogleFonts.cherryCreamSoda(
                fontSize: size.width * 0.07,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              phoneValue ?? "No number",
              textAlign: TextAlign.center,
              style: GoogleFonts.anekDevanagari(
                fontSize: size.width * 0.038,
                color: colors.hintColor,
              ),
            ),
            Container(
              height: size.height * 0.05,
              width: size.width * 0.35,
              decoration: BoxDecoration(
                color: colors.primaryTextColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "Edit Profile",
                  style: GoogleFonts.anekDevanagari(
                    color: colors.secondaryTextColor,
                    fontSize: size.width * 0.045,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.15),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 228, 228),
                border: Border.all(color: colors.hintColor, width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: sides.primaryPadding,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Clarity.notification_solid,
                      color: colors.primaryColor,
                    ),
                    title: Text(
                      "Push Notifications",
                      style: GoogleFonts.anekDevanagari(
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    trailing: Icon(Bootstrap.arrow_right),
                    visualDensity: VisualDensity(vertical: 2),
                  ),
                  CustomDivider(),
                  ListTile(
                    leading: Icon(
                      Clarity.note_solid,
                      color: colors.primaryColor,
                    ),
                    title: Text(
                      "Privacy Policy",
                      style: GoogleFonts.anekDevanagari(
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    trailing: Icon(Bootstrap.arrow_right),
                    visualDensity: VisualDensity(vertical: 2),
                  ),
                  CustomDivider(),
                  ListTile(
                    leading: Icon(
                      Clarity.help_solid,
                      color: colors.primaryColor,
                    ),
                    title: Text(
                      "Support",
                      style: GoogleFonts.anekDevanagari(
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    trailing: Icon(Bootstrap.arrow_right),
                    visualDensity: VisualDensity(vertical: 2),
                  ),
                  CustomDivider(),
                  ListTile(
                    leading: Icon(
                      Clarity.logout_solid,
                      color: colors.primaryColor,
                    ),
                    title: Text(
                      "Log out",
                      style: GoogleFonts.anekDevanagari(
                        fontSize: size.width * 0.04,
                      ),
                    ),
                    trailing: Icon(Bootstrap.arrow_right),
                    visualDensity: VisualDensity(vertical: 2),
                    onTap: () {
                      authServices.signOutUser();
                      Navigator.of(context).pushAndRemoveUntil(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  SigninPage(),
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
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.25),
          ],
        ),
      ),
    );
  }
}
