/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-23 19:26:23
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 15:03:11
/// @FilePath: lib/widgets/challenge_progress_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/colors/custom_colors.dart';
import 'package:code202/fonts/custom_fonts.dart';
import 'package:code202/models/challenge.dart';
import 'package:code202/models/player.dart';
import 'package:code202/models/stats.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChallengeProgressWidget extends StatefulWidget {
  const ChallengeProgressWidget(
      {super.key,
      required this.stats,
      required this.player,
      required this.challenges});
  final Stats stats;
  final List<Challenge> challenges;
  final Player player;

  @override
  State<ChallengeProgressWidget> createState() =>
      _ChallengeProgressWidgetState();
}

class _ChallengeProgressWidgetState extends State<ChallengeProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 29 / 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.yellow.shade800),
          child: Column(
            children: [
              Text(
                "${widget.player.completedChallenges.length} out of ${widget.challenges.length}",
                style: CustomFonts()
                    .statsFontCustomColor(Colors.yellow.shade100, 14),
              ),
              Text(
                "Completed",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade200,
                    fontSize: 16),
              )
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 29 / 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: CustomColors().devotion_pink),
          child: Column(
            children: [
              Text(
                "Level ${widget.stats.devLevel}",
                style: CustomFonts()
                    .statsFontCustomColor(Colors.pink.shade100, 14),
              ),
              Text(
                "Devotion",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade200,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 29 / 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.green),
          child: Column(
            children: [
              Text(
                "${widget.player.co2Saved.toStringAsFixed(2)} CO₂",
                style: CustomFonts()
                    .statsFontCustomColor(Colors.green.shade100, 14),
              ),
              Text(
                "Saved",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade200,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ],
    );
  }
}
