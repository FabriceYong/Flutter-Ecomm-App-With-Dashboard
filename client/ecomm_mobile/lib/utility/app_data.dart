import 'package:ecomm_mobile/utility/bottom_navy_bar_item.dart';
import 'package:flutter/material.dart';

class AppData {
  const AppData._();

  static List<Color> randomColors = [
    const Color(0xFFFCE4EC),
    const Color(0xFFF3E5F5),
    const Color(0xFFEDE7F6),
    const Color(0xFFE3F2FD),
    const Color(0xFFE0F2F1),
    const Color(0xFFF1F8E9),
    const Color(0xFFFFF8E1),
    const Color(0xFFECEFF1),
  ];

  static List<Color> randomPosterColors = [
    const Color(0xFFE70D56),
    const Color(0xFF9006A4),
    const Color(0xFF137C0B),
    const Color(0xFF0F2EDE),
    const Color(0xFFECBE23),
    const Color(0xFFA60FF1),
    const Color(0xFF0AE5CF),
    const Color(0xFFE518D1),
  ];

  static List<BottomNavyBarItem> bottomNavBarItems = [
    BottomNavyBarItem('Home', const Icon(Icons.home), const Color(0xFFEC6813)),
    BottomNavyBarItem(
        'Favorite', const Icon(Icons.favorite), const Color(0xFFEC6813)),
    BottomNavyBarItem(
        'Cart', const Icon(Icons.shopping_cart), const Color(0xFFEC6813)),
    BottomNavyBarItem(
        'Profile', const Icon(Icons.person), const Color(0xFFEC6813)),
  ];
}
