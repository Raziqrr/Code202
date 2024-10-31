/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-22 13:25:43
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-24 20:51:10
/// @FilePath: lib/widgets/custom_navigation_bar.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatefulWidget {
  CustomNavigationBar({super.key, required this.currentIndex});
  int currentIndex;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  List<BottomNavigationBarItem> navigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: navigationItems);
  }
}
