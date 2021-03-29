import 'package:flutter/material.dart';

class SectionProvider with ChangeNotifier {
  int currentTabIndex = 0;

  setTabIndex(int index) {
    currentTabIndex = index;
    notifyListeners();
  }
}
