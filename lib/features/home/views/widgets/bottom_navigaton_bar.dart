import 'package:animations/animations.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/features/profile/views/pages/profile_page.dart';
import 'package:matrimony/utils/colors.dart';

class BottomNavBar extends HookWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    const List<TabItem> items = [
      TabItem(icon: Clarity.home_solid, title: "Home"),
      TabItem(icon: Clarity.user_solid, title: "Profile"),
    ];
    final colors = Colours();
    final selectedIndex = useState(0);
    return BottomBarFloating(
      items: items,
      backgroundColor: colors.secondaryTextColor,
      color: const Color.fromARGB(255, 168, 205, 202),
      colorSelected: colors.primaryColor,
      onTap: (index) {
        if (index == 1) {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ProfilePage(),
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
        }
      },
      indexSelected: selectedIndex.value,
      duration: Duration(milliseconds: 100),
    );
  }
}
