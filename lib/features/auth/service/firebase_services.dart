import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:matrimony/utils/snackbar.dart';

class FirebaseServices {
  void createUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      snackBar("Verify email and continue again", context, 2);
    } catch (e) {
      snackBar(e.toString(), context, 2);
    }
  }

  Future<bool> signInUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      snackBar(e.toString(), context, 2);
      return false;
    }
  }
}
