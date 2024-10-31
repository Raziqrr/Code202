/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-20 23:32:25
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-28 23:34:15
/// @FilePath: lib/widgets/rank_emblem_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置
import 'package:code202/models/rank_and_level_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/player.dart';

class RankEmblemWidget extends StatelessWidget {
  const RankEmblemWidget({super.key, required this.player});
  final Player player;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            CupertinoIcons.tree,
            size: 18,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            Rank().getRank(player.level),
            style: GoogleFonts.uncialAntiqua(),
          ),
        ],
      ),
    );
  }
}
