/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-23 20:04:35
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 20:00:15
/// @FilePath: lib/widgets/minimized_challenge_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置
import 'package:code202/models/challenge.dart';
import 'package:code202/pages/challenge_detail_page.dart';
import 'package:emoji_data/emoji_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/player.dart';

class MinimizedChallengeWidget extends StatefulWidget {
  const MinimizedChallengeWidget(
      {super.key,
      required this.color,
      required this.textColor,
      required this.difficulty,
      required this.categories,
      required this.player,
      required this.challenge,
      required this.isDaily,
      required this.prefs});
  final Color color;
  final Color textColor;
  final String difficulty;
  final List<String> categories;
  final Player player;
  final Challenge challenge;
  final bool isDaily;
  final SharedPreferences prefs;

  @override
  State<MinimizedChallengeWidget> createState() =>
      _MinimizedChallengeWidgetState();
}

class _MinimizedChallengeWidgetState extends State<MinimizedChallengeWidget> {
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

  void getCompleted() async {
    if (widget.isDaily) {
      completed = widget.prefs.getStringList("completedDailies") ?? [];
    } else {
      completed = widget.player.completedChallenges;
    }
    setState(() {});
    print(completed);
    print("init complete");
  }

  bool isCompleted() {
    return completed.contains(widget.challenge.id);
  }

  List<String> completed = [];

  @override
  void initState() {
    // TODO: implement initState
    getCompleted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: widget.color),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.challenge.name,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: widget.textColor),
                ),
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
                Row(
                  children: [
                    Text(
                      widget.isDaily
                          ? "+${widget.challenge.getCoins() * 2}"
                          : "+${widget.challenge.getCoins()}",
                      style: GoogleFonts.poppins(
                        shadows: [
                          Shadow(
                              color: Colors.yellow.shade600.withOpacity(0.2),
                              blurRadius: 4)
                        ],
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        fontSize: 16,
                        color: isCompleted()
                            ? widget.isDaily
                                ? Colors.yellow.shade500
                                : Colors.yellow.shade700
                            : Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Icon(
                      CupertinoIcons.money_dollar_circle_fill,
                      color: isCompleted()
                          ? widget.isDaily
                              ? Colors.yellow.shade500
                              : Colors.yellow.shade700
                          : Colors.white,
                      size: 18,
                    )
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: isCompleted() ? 1 : 0,
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
                  isCompleted() ? "1/1" : "0/1",
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
