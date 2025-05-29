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
      snackBar("Verify email and continue again", context);
    } catch (e) {
      snackBar(e.toString(), context);
    }
  }
}
