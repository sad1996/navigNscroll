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
  /// Controls which tabs should have its content built. This enables us to
  /// lazy instantiate it.
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
        // We're preventing the root navigator from popping and closing the app
        // when the back button is pressed and the inner navigator can handle
        // it. That occurs when the inner has more than one page on its stack.
        // You can comment the onWillPop callback and watch "the bug".
        onWillPop: () async => !await widget
            .sections[Provider.of<SectionProvider>(context, listen: false)
                .currentTabIndex]
            .navKey
            .currentState!
            .maybePop(),
        child: Scaffold(
          // The Stack is what allows us to retain state across tab
          // switches by keeping all of our views in the widget tree.
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
          // We should build the tab content only if it was already built or
          // if it is currently selected.
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
          // The key enables us to access the Navigator's state inside the
          // onWillPop callback and for emptying its stack when a tab is
          // re-selected. That is why a GlobalKey is needed instead of
          // a simpler ValueKey.
          key: screen.navKey,
          // Since this isn't the purpose of this sample, we're not using
          // named routes. Because of that, the onGenerateRoute callback
          // will be called only for the initial route.
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
      // If the user is re-selecting the tab, the common
      // behavior is to empty the stack.
      widget.sections[newIndex].navKey.currentState!
          .popUntil((route) => route.isFirst);
    }

    // If we're running on iOS there's no need to rebuild the Widget to reflect
    // the tab change.
    provider.setTabIndex(newIndex);
  }
}
