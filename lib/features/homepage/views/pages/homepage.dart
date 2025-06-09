import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/auth/view/pages/signin_page.dart';
import 'package:matrimony/features/homepage/service/database_service.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/fontstyle.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Fontstyle();
    final colors = Colours();
    final databaseFieldService = DatabaseFieldServices();
    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colors.primaryColor,
        title: Row(
          children: [
            Image.asset("assets/images/matrimony_logo.png", scale: 16),
            Text("Matrimony", style: textStyle.appBarTitleStyle),
          ],
        ),
        shape: Border(
          bottom: BorderSide(color: colors.secondaryColor, width: 1),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      SigninPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return SharedAxisTransition(
                          animation: animation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                ),
              );
            },
            icon: Icon(Clarity.logout_line),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: databaseFieldService.getGenderSpecifiedUsers("Male"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching users"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No male users found"));
          }
          final users = snapshot.data;
          return ListView.builder(
            itemCount: users?.length,
            itemBuilder: (context, index) {
              final user = users?[index];
              return ListTile(
                title: Text(
                  user?['name'],
                  style: TextStyle(fontSize: 24, color: Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
