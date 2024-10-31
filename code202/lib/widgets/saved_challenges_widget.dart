/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-23 19:40:47
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-29 14:02:23
/// @FilePath: lib/widgets/saved_challenges_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/models/challenge.dart';
import 'package:code202/widgets/minimized_saved_challenge_widget.dart';
import 'package:flutter/material.dart';

import '../models/player.dart';

class SavedChallengesWidget extends StatelessWidget {
  const SavedChallengesWidget(
      {super.key, required this.player, required this.challenges});
  final Player player;
  final List<Challenge> challenges;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MinimizedSavedChallengeWidget(
          color: Colors.green.shade100,
          textColor: Colors.green,
          difficulty: 'Easy',
          categories: ["Food", "Stuff"],
          player: player,
          challenge: challenges.first,
        )
      ],
    );
  }
}
