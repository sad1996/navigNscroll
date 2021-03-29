import 'package:build_context/build_context.dart';
import 'package:flutter/material.dart';
import 'package:navig_scroll/model/location.dart';
import 'package:navig_scroll/util/constant.dart';

import 'widgets/item.dart';

class DetailPage extends StatelessWidget {
  DetailPage({required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.place),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 180,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: locations
                    .map((location) => InkWell(
                          onTap: () => context.push(MaterialPageRoute(
                              builder: (_) => DetailPage(
                                    location: location,
                                  ))),
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Stack(
                              children: [
                                buildBackground(location.imageUrl),
                                buildGradient(),
                                buildTitleAndSubtitle(
                                    location.name, location.place)
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Column(
              children: locations
                  .map((location) => InkWell(
                        onTap: () => context.push(MaterialPageRoute(
                            builder: (_) => DetailPage(
                                  location: location,
                                ))),
                        child: Container(
                          margin: EdgeInsets.all(5),
                          constraints: BoxConstraints(minHeight: 200),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: Stack(
                            children: [
                              buildBackground(location.imageUrl),
                              buildGradient(),
                              buildTitleAndSubtitle(
                                  location.name, location.place)
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
