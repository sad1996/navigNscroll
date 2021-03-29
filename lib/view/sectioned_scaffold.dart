import 'package:flutter/material.dart';
import 'package:navig_scroll/model/section.dart';
import 'package:navig_scroll/provider/section_provider.dart';
import 'package:provider/provider.dart';

class SectionedScaffold extends StatefulWidget {
  SectionedScaffold({required this.sections});

  final List<Section> sections;

  @override
  _SectionedScaffoldState createState() => _SectionedScaffoldState();
}

class _SectionedScaffoldState extends State<SectionedScaffold> {
  final List<bool> _shouldBuildView = <bool>[];

  @override
  void initState() {
    _shouldBuildView.addAll(List<bool>.filled(
      widget.sections.length,
      false,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => !await widget
            .sections[Provider.of<SectionProvider>(context, listen: false)
                .currentTabIndex]
            .navKey
            .currentState!
            .maybePop(),
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: widget.sections
                .map((section) => _buildPageFlow(
                      widget.sections.indexOf(section),
                      section,
                    ))
                .toList(),
          ),
          bottomNavigationBar: Consumer<SectionProvider>(
            builder: (_, provider, __) => BottomNavigationBar(
              currentIndex: provider.currentTabIndex,
              items:
                  widget.sections.map((section) => section.navBarItem).toList(),
              onTap: onTabSelected,
            ),
          ),
        ),
      );

  Widget _buildPageFlow(
    int tabIndex,
    Section screen,
  ) {
    return KeyedSubtree(
      key: GlobalKey(),
      child: Consumer<SectionProvider>(
        builder: (_, provider, child) {
          final isCurrentlySelected = tabIndex == provider.currentTabIndex;
          _shouldBuildView[tabIndex] =
              isCurrentlySelected || _shouldBuildView[tabIndex];
          if (!_shouldBuildView[tabIndex])
            return SizedBox();
          else if (isCurrentlySelected)
            return child!;
          else
            return Offstage(child: child!);
        },
        child: Navigator(
          key: screen.navKey,
          onGenerateRoute: (settings) => MaterialPageRoute(
            settings: settings,
            builder: screen.screenBuilder,
          ),
        ),
      ),
    );
  }

  void onTabSelected(int newIndex) {
    var provider = Provider.of<SectionProvider>(context, listen: false);
    if (provider.currentTabIndex == newIndex) {
      widget.sections[newIndex].navKey.currentState!
          .popUntil((route) => route.isFirst);
    }
    provider.setTabIndex(newIndex);
  }
}
