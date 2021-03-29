import 'package:flutter/material.dart';
import 'package:navig_scroll/provider/section_provider.dart';
import 'package:navig_scroll/util/theme.dart';
import 'package:provider/provider.dart';

import 'view/landing_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SectionProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation & Scroll',
      theme: appTheme,
      home: LandPage(),
    );
  }
}
