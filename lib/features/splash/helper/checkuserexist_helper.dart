import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:matrimony/features/auth/service/database_service.dart';
import 'package:matrimony/features/auth/view/pages/signin_page.dart';
import 'package:matrimony/features/home/views/pages/homepage.dart';
import 'package:matrimony/features/profile/helper/connectivity_check_helper.dart';
import 'package:matrimony/features/userdetails/services/location_service.dart';
import 'package:matrimony/utils/material_banner.dart';

Future<void> checkUserExists(BuildContext context) async {
  await Future.delayed(Duration(seconds: 2));
  final user = FirebaseAuth.instance.currentUser;
  final databaseServices = DatabaseServices();
  final isConnected = checkConnectivity();
  if (await isConnected) {
    try {
      if (user != null) {
        final location = await getCurrentLocation(context);
        databaseServices.updateLocationAndDeviceInfoInDatabase(location);
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        final isUserExists = doc.exists;
        if (isUserExists) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  Homepage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    final tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: Curves.easeInOut));
                    final offSetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offSetAnimation,
                      child: child,
                    );
                  },
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 500),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SigninPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    final tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: Curves.easeInOut));
                    final offSetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offSetAnimation,
                      child: child,
                    );
                  },
            ),
          );
        }
      } else {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
                SigninPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  final tween = Tween(
                    begin: begin,
                    end: end,
                  ).chain(CurveTween(curve: Curves.easeInOut));
                  final offSetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offSetAnimation,
                    child: child,
                  );
                },
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  } else {
    banner("No internet connection", context);
  }
}
