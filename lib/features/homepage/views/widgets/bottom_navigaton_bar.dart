import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icons_plus/icons_plus.dart';
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
    final indexSelected = useState(0);
    return BottomBarFloating(
      items: items,
      backgroundColor: colors.secondaryTextColor,
      color: const Color.fromARGB(255, 236, 182, 100),
      colorSelected: colors.primaryColor,
      onTap: (index) {
        indexSelected.value = index;
      },
      indexSelected: indexSelected.value,
      duration: Duration(milliseconds: 100),
    );
  }
}
