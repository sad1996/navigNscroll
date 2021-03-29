import 'package:build_context/build_context.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navig_scroll/model/location.dart';
import 'package:navig_scroll/util/constant.dart';

import 'widgets/item.dart';

class DetailPage extends StatelessWidget {
  DetailPage({required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: appBarHeight,
          pinned: true,
          floating: false,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(location.name),
            background: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: location.imageUrl,
                  fit: BoxFit.cover,
                  height: appBarHeight,
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment(0, .35),
                      colors: <Color>[Color(0xC0000000), Color(0x00000000)],
                    ),
                  ),
                ),
              ],
            ),
            stretchModes: [StretchMode.zoomBackground],
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
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
        )
      ],
    );
  }
}
