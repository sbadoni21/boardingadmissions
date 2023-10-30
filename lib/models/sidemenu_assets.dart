import 'package:boardingadmissions/views/chat.dart';
import 'package:boardingadmissions/views/home_page.dart';
import 'package:boardingadmissions/views/search_page.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> sideMenuItems = [
  {
    "icon": Icons.home,
    "text": "Home",
    "key": "home",
    'route': const HomePage()
  },
  {
    "icon": Icons.search,
    "text": "Search",
    "key": "search",
    'route': const SearchBarButton()
  },
  {"icon": Icons.person, "text": "NA", "key": "user", 'route': ()},
  {
    "icon": Icons.settings,
    "text": "Settings",
    "key": "settings",
    'route': () {}
  },
  {"icon": Icons.assistant, "text": "Enquiry", "key": "chat", 'route': Chat()},
  {
    "icon": Icons.logout,
    "text": "Logout",
    "key": "logout",
    "route": () async {}
  }
];
