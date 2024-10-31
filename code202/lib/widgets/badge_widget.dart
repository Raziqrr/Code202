/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-21 00:03:26
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-22 11:33:17
/// @FilePath: lib/widgets/badge_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({super.key, required this.imagePath});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2),
          color: Colors.blue,
          borderRadius: BorderRadius.circular(100),
          image: null //DecorationImage(image: AssetImage(imagePath))
          ),
    );
  }
}
