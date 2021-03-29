import 'package:flutter/material.dart';

class Section {
  const Section({
    required this.navBarItem,
    required this.navKey,
    required this.screenBuilder,
  });

  final BottomNavigationBarItem navBarItem;
  final GlobalKey<NavigatorState> navKey;
  final WidgetBuilder screenBuilder;
}

class NavBarItem {
  final String title;
  final IconData icon;
  final IconData activeIcon;
  final GlobalKey<NavigatorState> sectionNavKey;

  const NavBarItem({
    required this.title,
    required this.icon,
    required this.activeIcon,
    required this.sectionNavKey,
  });
}
