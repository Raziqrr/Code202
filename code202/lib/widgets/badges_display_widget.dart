/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-20 23:35:14
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-22 11:33:47
/// @FilePath: lib/widgets/badges_display_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/widgets/badge_widget.dart';
import 'package:code202/widgets/round_image_widget.dart';
import 'package:flutter/material.dart';

class BadgesDisplayWidget extends StatelessWidget {
  const BadgesDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BadgeWidget(imagePath: ""),
        SizedBox(
          width: 10,
        ),
        BadgeWidget(imagePath: ""),
        SizedBox(
          width: 10,
        ),
        BadgeWidget(imagePath: ""),
        SizedBox(
          width: 10,
        ),
        BadgeWidget(imagePath: ""),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
