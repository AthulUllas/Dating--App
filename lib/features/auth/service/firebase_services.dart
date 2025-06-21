import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:matrimony/utils/snackbar.dart';

class FirebaseServices {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<bool> createUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      snackBar("Verify email and Sign In", context, 2, FlashPosition.top);
      await FirebaseAuth.instance.currentUser?.reload();

      return true;
    } catch (e) {
      snackBar(e.toString(), context, 2, FlashPosition.top);
      return false;
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
      snackBar(e.toString(), context, 2, FlashPosition.top);
      return false;
    }
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // return userCredential;
      return true;
    } catch (e) {
      snackBar(e.toString(), context, 5, FlashPosition.top);
      return false;
    }
  }

  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool?> updateUserEmail(String newMail) async {
    try {
      await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(newMail);
      return true;
    } catch (e) {
      debugPrint(
        "<-------------------------${e.toString()}---------------------------->",
      );
      return false;
    }
  }

  Future<void> reAuthenticateUser(String email, String password) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final cred = EmailAuthProvider.credential(
          email: email,
          password: password,
        );
        await user.reauthenticateWithCredential(cred);
      } catch (e) {
        debugPrint(
          "<----------------------${e.toString()}------------------------>",
        );
      }
    }
  }
}
