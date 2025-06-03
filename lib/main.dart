import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:matrimony/features/splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init('name');
  GetStorage.init('phone');
  GetStorage.init('gender');
  GetStorage.init('dp');
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDELHJE4ueIRBlE9u3qdpnJUNUvmoAEWEc",
      appId: "1:97152258989:android:c3ad71cc48c27d5ffe8724",
      messagingSenderId: "97152258989",
      projectId: "matrimony--app",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matrimony App',
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
