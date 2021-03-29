import 'package:flutter/material.dart';
import 'package:navig_scroll/model/location.dart';
import 'package:navig_scroll/model/section.dart';

const appName = 'Navigation & Scroll';

final List<Section> appSections = [
  Section(
    title: 'Home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
    navKey: GlobalKey<NavigatorState>(),
  ),
  Section(
    title: 'Media',
    icon: Icons.camera_alt_outlined,
    activeIcon: Icons.camera_alt,
    navKey: GlobalKey<NavigatorState>(),
  ),
  Section(
    title: 'Profile',
    icon: Icons.supervised_user_circle_outlined,
    activeIcon: Icons.supervised_user_circle,
    navKey: GlobalKey<NavigatorState>(),
  ),
];

const defaultDuration = Duration(milliseconds: 500);
const urlPrefix =
    'https://flutter.dev/docs/cookbook/img-files/effects/parallax';

const locations = [
  Location(
    name: 'Mount Rushmore',
    place: 'U.S.A',
    imageUrl: '$urlPrefix/01-mount-rushmore.jpg',
  ),
  Location(
    name: 'Singapore',
    place: 'China',
    imageUrl: '$urlPrefix/02-singapore.jpg',
  ),
  Location(
    name: 'Machu Picchu',
    place: 'Peru',
    imageUrl: '$urlPrefix/03-machu-picchu.jpg',
  ),
  Location(
    name: 'Vitznau',
    place: 'Switzerland',
    imageUrl: '$urlPrefix/04-vitznau.jpg',
  ),
  Location(
    name: 'Bali',
    place: 'Indonesia',
    imageUrl: '$urlPrefix/05-bali.jpg',
  ),
  Location(
    name: 'Mexico City',
    place: 'Mexico',
    imageUrl: '$urlPrefix/06-mexico-city.jpg',
  ),
  Location(
    name: 'Cairo',
    place: 'Egypt',
    imageUrl: '$urlPrefix/07-cairo.jpg',
  ),
];
