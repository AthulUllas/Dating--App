import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:matrimony/utils/snackbar.dart';

class DatabaseServices {
  Future<void> registerUserInDatabase(
    String email,
    BuildContext context,
    String? name,
    String? phone,
    String? gender,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final uid = user.uid;
        FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': name,
          'email': email,
          'phone': phone,
          'gender': gender,
          'createdAt': DateTime.now(),
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      snackBar("Please login first", context, 1, FlashPosition.top);
    }
  }
}
