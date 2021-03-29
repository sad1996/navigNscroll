import 'package:build_context/build_context.dart';
import 'package:flutter/material.dart';
import 'package:navig_scroll/util/constant.dart';
import 'package:navig_scroll/view/widgets/item.dart';

import 'detail_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.pageIndex}) : super(key: key);

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = locations
        .map(
          (location) => Center(
            child: InkWell(
              onTap: () => context.push(MaterialPageRoute(
                  builder: (_) => DetailPage(
                        location: location,
                      ))),
              child: Container(
                margin: EdgeInsets.all(5),
                constraints: BoxConstraints(
                    minHeight: 200, maxWidth: context.mediaQuerySize.width),
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: CardItem(location),
              ),
            ),
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(getPageTitle(pageIndex)),
      ),
      body: pageIndex != 3
          ? ListView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(5),
              scrollDirection:
                  pageIndex.isEven ? Axis.horizontal : Axis.vertical,
              children: children,
            )
          : GridView.count(
              crossAxisCount: 2,
              children: children,
            ),
    );
  }

  String getPageTitle(int index) {
    switch (index) {
      case 1:
        return 'Vertical Scroll';
      case 2:
        return 'Horizontal Scroll';
      case 3:
        return 'Grid Scroll';
      default:
        return '';
    }
  }
}
