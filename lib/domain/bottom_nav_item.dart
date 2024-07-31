import 'package:flutter/material.dart';

class BottomNavItem {
  final String label;
  final String icon;
  final Widget page;

  BottomNavItem({
    required this.label,
    required this.icon,
    required this.page,
  });
}
