/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-24 09:58:13
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-30 03:22:53
/// @FilePath: lib/widgets/minimized_saved_challenge_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/models/challenge.dart';
import 'package:code202/models/player.dart';
import 'package:code202/pages/challenge_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MinimizedSavedChallengeWidget extends StatefulWidget {
  const MinimizedSavedChallengeWidget(
      {super.key,
      required this.color,
      required this.textColor,
      required this.difficulty,
      required this.categories,
      required this.player,
      required this.challenge});
  final Color color;
  final Color textColor;
  final String difficulty;
  final List<String> categories;
  final Player player;
  final Challenge challenge;

  @override
  State<MinimizedSavedChallengeWidget> createState() =>
      _MinimizedSavedChallengeWidgetState();
}

class _MinimizedSavedChallengeWidgetState
    extends State<MinimizedSavedChallengeWidget> {
  Color getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "easy":
        return Colors.green;
      case "medium":
        return Colors.yellow.shade600;
      case "hard":
        return Colors.red.shade500;
      default:
        return Colors.pink;
    }
  }

  Color getDifficultyTextColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "easy":
        return Colors.green.shade100;
      case "medium":
        return Colors.yellow.shade100;
      case "hard":
        return Colors.red.shade100;
      default:
        return Colors.pink.shade100;
    }
  }

  Widget getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "home":
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(3)),
          child: Icon(
            Icons.maps_home_work_sharp,
            color: Colors.grey,
            size: 14,
          ),
        );
      case "transport":
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(3)),
            child: Icon(Icons.directions_car,
                size: 14, color: Colors.red.shade100));
      case "food":
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.orange.shade700,
                borderRadius: BorderRadius.circular(3)),
            child: Icon(Icons.restaurant,
                size: 14, color: Colors.orange.shade100));
      case "stuff":
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.purple.shade700,
                borderRadius: BorderRadius.circular(3)),
            child: Icon(Icons.checkroom_rounded,
                size: 14, color: Colors.purple.shade100));
      default:
        return Icon(Icons.info, size: 14, color: Colors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ChallengeDetailPage(
            categories: ["Food", "Home"],
            difficulty: 'Hard',
            player: widget.player,
            challenge: widget.challenge,
            isDaily: false,
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Be vegan",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: widget.textColor),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.change_circle_outlined,
                      color: widget.textColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      "Repeat",
                      style: GoogleFonts.poppins(
                          color: widget.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: getDifficultyColor(widget.difficulty),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  child: Row(
                    mainAxisSize:
                        MainAxisSize.min, // Ensure the row takes minimal space
                    children: List.generate(
                      widget.difficulty.toLowerCase() == "hard"
                          ? 3
                          : widget.difficulty.toLowerCase() == "medium"
                              ? 2
                              : widget.difficulty.toLowerCase() == "easy"
                                  ? 1
                                  : 0, // Calculate the number of stars based on difficulty
                      (index) => Icon(
                        Icons.star,
                        color: getDifficultyTextColor(widget.difficulty),
                        size: 14,
                      ), // Display stars
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: List.generate(
                    widget.categories
                        .length, // Calculate the number of stars based on difficulty
                    (index) => getCategoryIcon(
                        widget.categories[index]), // Display stars
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "+ 200 pts",
                  style: GoogleFonts.poppins(
                      shadows: [
                        Shadow(
                            color: Colors.yellow.shade600.withOpacity(0.2),
                            blurRadius: 4)
                      ],
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(4),
                    color: getDifficultyColor(widget.difficulty),
                    backgroundColor: Colors.grey.shade100.withOpacity(0.7),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "0/1",
                  style: GoogleFonts.poppins(
                      color: widget.textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
