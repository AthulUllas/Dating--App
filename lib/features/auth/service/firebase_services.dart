import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:matrimony/utils/snackbar.dart';

class FirebaseServices {
  void createUser(String email, String password, BuildContext context) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await FirebaseAuth.instance.currentUser?.sendEmailVerification();
    snackBar("Check email and verify", context);
  }
}
