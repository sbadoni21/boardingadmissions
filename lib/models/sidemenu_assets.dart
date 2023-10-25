import 'package:boardingadmissions/services/authentication_service.dart';
import 'package:boardingadmissions/views/chat.dart';
import 'package:boardingadmissions/views/home_page.dart';
import 'package:boardingadmissions/views/profile_page.dart';
import 'package:boardingadmissions/views/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> sideMenuItems = [
  {"icon": Icons.home, "text": "Home", "key": "home", 'route': HomePage()},
  {
    "icon": Icons.search,
    "text": "Search",
    "key": "search",
    'route': SearchBarButton()
  },
  {"icon": Icons.person, "text": "NA", "key": "user", 'route': ()},
  {
    "icon": Icons.settings,
    "text": "Settings",
    "key": "settings",
    'route': () {}
  },
  {"icon": Icons.chat, "text": "Chat", "key": "chat", 'route': () {}},
  {
    "icon": Icons.logout,
    "text": "Logout",
    "key": "logout",
    "route": () async {
      
    }
  }
];
