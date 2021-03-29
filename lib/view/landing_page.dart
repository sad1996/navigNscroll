import 'package:flutter/material.dart';
import 'package:navig_scroll/model/section.dart';
import 'package:navig_scroll/util/constant.dart';

import 'home_screen.dart';
import 'sectioned_scaffold.dart';

class LandPage extends StatelessWidget {
  static const String routeName = "LandPage";

  @override
  Widget build(BuildContext context) {
    return SectionedScaffold(
      sections: [
        for (var section in appSections)
          Section(
            navBarItem: BottomNavigationBarItem(
              label: section.title,
              icon: Icon(section.icon),
              activeIcon: Icon(section.activeIcon),
            ),
            navKey: section.sectionNavKey,
            screenBuilder: (context) => HomeScreen(
              pageIndex: (appSections.indexOf(section) + 1),
            ),
          ),
      ],
    );
  }
}
