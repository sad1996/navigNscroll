import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navig_scroll/model/location.dart';

class CardItem extends StatelessWidget {
  const CardItem(this.location);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(location.imageUrl),
        buildGradient(),
        buildTitleAndSubtitle(location.name, location.place)
      ],
    );
  }
}

Widget buildBackground(String imageUrl) => CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
    );

Widget buildGradient() => Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.95],
          ),
        ),
      ),
    );

Widget buildTitleAndSubtitle(String name, String place) => Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            place,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
