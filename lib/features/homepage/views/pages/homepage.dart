import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/auth/view/pages/signin_page.dart';
import 'package:matrimony/features/homepage/helper/text_hide_helper.dart';
import 'package:matrimony/features/homepage/service/database_service.dart';
import 'package:matrimony/features/homepage/views/widgets/gender_select_button.dart';
import 'package:matrimony/utils/colors.dart';
import 'package:matrimony/utils/dimensions.dart';
import 'package:matrimony/utils/fontstyle.dart';

class Homepage extends HookWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = Fontstyle();
    final colors = Colours();
    final databaseFieldService = DatabaseFieldServices();
    final gender = useState("Male");
    final isMaleTapped = useState(true);
    final isFemaleTapped = useState(false);
    final isOtherTapped = useState(false);
    final size = MediaQuery.of(context).size;
    final sides = Dimensions();
    final currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colors.primaryColor,
        title: Row(
          children: [
            Image.asset("assets/images/matrimony_logo.png", scale: 16),
            Text("Matrimony", style: styles.appBarTitleStyle),
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
      body: Column(
        children: [
          SizedBox(height: size.height * 0.015),
          GestureDetector(
            onTap: () {
              gender.value = "Male";
              isMaleTapped.value = true;
              isFemaleTapped.value
                  ? isFemaleTapped.value = false
                  : isFemaleTapped.value = isFemaleTapped.value;
              isOtherTapped.value
                  ? isOtherTapped.value = false
                  : isOtherTapped.value = isOtherTapped.value;
            },
            child: GenderSelectButton(
              color: isMaleTapped.value
                  ? colors.homepageGenderButtonColor
                  : colors.scaffoldBackgroundColor,
              text: Text(
                "Male Users",
                style: GoogleFonts.anekDevanagari(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isMaleTapped.value
                      ? colors.secondaryTextColor
                      : colors.primaryTextColor,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          GestureDetector(
            onTap: () {
              gender.value = "Female";
              isFemaleTapped.value = true;
              isMaleTapped.value
                  ? isMaleTapped.value = false
                  : isMaleTapped.value = isMaleTapped.value;
              isOtherTapped.value
                  ? isOtherTapped.value = false
                  : isOtherTapped.value = isOtherTapped.value;
            },
            child: GenderSelectButton(
              color: isFemaleTapped.value
                  ? colors.homepageGenderButtonColor
                  : colors.scaffoldBackgroundColor,
              text: Text(
                "Female Users",
                style: GoogleFonts.anekDevanagari(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isFemaleTapped.value
                      ? colors.secondaryTextColor
                      : colors.primaryTextColor,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.01),
          GestureDetector(
            onTap: () {
              gender.value = "Other";
              isOtherTapped.value = true;
              isMaleTapped.value
                  ? isMaleTapped.value = false
                  : isMaleTapped.value = isMaleTapped.value;
              isFemaleTapped.value
                  ? isFemaleTapped.value = false
                  : isFemaleTapped.value = isFemaleTapped.value;
            },
            child: GenderSelectButton(
              color: isOtherTapped.value
                  ? colors.homepageGenderButtonColor
                  : colors.scaffoldBackgroundColor,
              text: Text(
                "Gay/Les",
                style: GoogleFonts.anekDevanagari(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isOtherTapped.value
                      ? colors.secondaryTextColor
                      : colors.primaryTextColor,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Expanded(
            child: FutureBuilder(
              future: databaseFieldService.getGenderSpecifiedUsers(
                gender.value,
                currentUserUid!,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error fetching users"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No users found"));
                }
                final users = snapshot.data;
                return ListView.builder(
                  itemCount: users?.length,
                  itemBuilder: (context, index) {
                    final user = users?[index];
                    final name = user?['name'];
                    final hidedText = hideText(name);
                    return Container(
                      decoration: BoxDecoration(
                        color: colors.primaryColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: colors.secondaryColor,
                          width: 1.5,
                        ),
                      ),
                      margin: sides.primaryPadding,
                      height: size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width: size.width * 0.0001),
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(
                              "assets/images/funny_dp.jpg",
                            ),
                          ),
                          Text(
                            hidedText,
                            style: GoogleFonts.anekDevanagari(
                              fontSize: 24,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(width: size.width * 0.18),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Clarity.phone_handset_solid),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Clarity.menu_line),
                          ),
                          SizedBox(width: size.width * 0.008),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
