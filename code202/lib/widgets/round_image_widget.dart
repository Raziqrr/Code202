/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-20 23:24:14
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 18:51:18
/// @FilePath: lib/widgets/round_image_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/models/player.dart';
import 'package:flutter/material.dart';

class RoundImageWidget extends StatelessWidget {
  RoundImageWidget({super.key, required this.imagePath});
  final String imagePath;

  Player player = Player(
      username: "",
      rank: "",
      xp: 0,
      level: 0,
      health: 0,
      coins: 0,
      co2Saved: 0,
      uid: "",
      completedChallenges: [],
      completedLessons: [],
      completedQuiz: [],
      profileAvatar: "");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green.shade700, width: 3),
          color: Colors.grey,
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(image: AssetImage(imagePath))
          //DecorationImage(fit: BoxFit.cover, image: AssetImage(imagePath))
          ),
    );
  }
}
