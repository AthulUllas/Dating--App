import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:matrimony/features/home/helper/text_hide_helper.dart';
import 'package:matrimony/features/home/service/database_service.dart';
import 'package:matrimony/features/home/views/widgets/bottom_navigaton_bar.dart';
import 'package:matrimony/features/home/views/widgets/gender_select_button.dart';
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
    final favoritedIndex = useState<int?>(null);
    Future<void> onRefresh() async {
      await databaseFieldService.getGenderSpecifiedUsers(
        gender.value,
        currentUserUid!,
      );
    }

    return Scaffold(
      backgroundColor: colors.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: colors.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/matrimony_logo.png", scale: 16),
            Text("Favmate", style: styles.appBarTitleStyle),
          ],
        ),
        shape: Border(
          bottom: BorderSide(color: colors.secondaryColor, width: 1),
        ),
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
                  return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: colors.primaryTextColor,
                      size: 50,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error fetching users",
                      style: styles.homepageMessageStyle,
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "No users were found !",
                      style: styles.homepageMessageStyle,
                    ),
                  );
                }
                final users = snapshot.data;
                return RefreshIndicator(
                  onRefresh: () async {
                    onRefresh;
                  },
                  displacement: 10,
                  child: ListView.builder(
                    itemCount: users?.length,
                    itemBuilder: (context, index) {
                      final isFavorited = favoritedIndex.value == index;
                      final user = users?[index];
                      final name = user?['name'];
                      final hidedText = hideText(name);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors.secondaryColor,
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
                              SizedBox(
                                width: 120,
                                child: Text(
                                  hidedText,
                                  style: GoogleFonts.anekDevanagari(
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.18),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Clarity.phone_handset_solid),
                              ),
                              IconButton(
                                onPressed: () {
                                  favoritedIndex.value = isFavorited
                                      ? null
                                      : index;
                                },
                                icon: Icon(
                                  isFavorited
                                      ? Clarity.favorite_solid
                                      : Clarity.favorite_line,
                                ),
                              ),
                              SizedBox(width: size.width * 0.008),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
