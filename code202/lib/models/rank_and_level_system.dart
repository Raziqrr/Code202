/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-28 22:58:34
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 19:09:32
/// @FilePath: lib/models/rank_and_level_system.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'dart:math';

class Rank {
  int getLevelCap(int currentLevel) {
    if (currentLevel < 1) {
      currentLevel = 1;
    }

    final double x = 10; // Scaling factor for level
    final double y = 2; // Growth rate exponent
    final int targetLevelWithin2Month = 10; // Target max level within 2 months

    // XP required formula with a reasonable scaling factor
    double xpRequired = (pow(currentLevel / x, y) * 15000) /
        (targetLevelWithin2Month * targetLevelWithin2Month);

    // Use rounding or toInt for conversion to int
    return xpRequired.round();
  }

  String getRank(int currentLevel) {
    final List<String> ranks = [
      "Seedling", // Level 1
      "Bud", // Level 2
      "Sprout", // Level 3
      "Leaf", // Level 4
      "Sapling", // Level 5
      "Tree", // Level 6
      "Forest", // Level 7
      "Verdant", // Level 8
      "Eden", // Level 9
      "Gaia" // Level 10
    ];
    if (currentLevel < 1) {
      return "Invalid level";
    } else if (currentLevel >= 1 && currentLevel < 30) {
      int rankIndex = (currentLevel - 1) ~/ 3;
      return ranks[rankIndex];
    } else if (currentLevel >= 30) {
      return "Gaia"; // Cap at Gaia for levels above 30
    } else {
      return "rank error";
    }
  }
}
