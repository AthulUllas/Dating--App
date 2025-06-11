import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:matrimony/utils/colors.dart';

class BottomNavBar extends HookWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Colours();
    final indexSelected = useState(0);
    return DotNavigationBar(
      items: [
        DotNavigationBarItem(icon: Icon(Clarity.home_solid)),
        DotNavigationBarItem(icon: Icon(Clarity.user_solid)),
      ],
      currentIndex: indexSelected.value,
      onTap: (index) {
        indexSelected.value = index;
      },
      selectedItemColor: colors.primaryColor,
      marginR: EdgeInsets.all(0),
      itemPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
    );
  }
}
