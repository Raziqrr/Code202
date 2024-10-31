/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-22 13:50:06
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 19:08:08
/// @FilePath: lib/widgets/minimized_profile_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/widgets/round_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/player.dart';
import '../models/rank_and_level_system.dart';

class MinimizedProfileWidget extends StatelessWidget {
  const MinimizedProfileWidget(
      {super.key, required this.imagePath, required this.player});
  final String imagePath;
  final Player player;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Lvl ${player.level}",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "${player.xp}/${Rank().getLevelCap(player.level)} XP",
                style: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.black.withOpacity(0.5)),
              ),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.grey.withOpacity(0.3),
                minHeight: 14,
                borderRadius: BorderRadius.circular(3),
                color: CupertinoColors.systemYellow,
                value: double.parse(
                    '${player.xp / Rank().getLevelCap(player.level)}'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
