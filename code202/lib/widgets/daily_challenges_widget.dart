/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-22 13:58:37
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 19:59:48
/// @FilePath: lib/widgets/daily_challenges_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/fonts/custom_fonts.dart';
import 'package:code202/models/player.dart';
import 'package:code202/pages/challenge_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/challenge.dart';
import '../models/challenge_manager.dart';

class DailyChallengesWidget extends StatefulWidget {
  DailyChallengesWidget(
      {super.key, required this.player, required this.challenges});
  final Player player;
  final List<Challenge> challenges;

  @override
  State<DailyChallengesWidget> createState() => _DailyChallengesWidgetState();
}

class _DailyChallengesWidgetState extends State<DailyChallengesWidget> {
  List<String> completed = [];

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    completed = prefs.getStringList("completedDailies") ?? [];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Daily Challenges",
                  style: CustomFonts().primary_text,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "(${completed.length}/3)",
                  style: CustomFonts()
                      .statsFontCustomColor(Colors.black.withOpacity(0.5), 16),
                ),
              ],
            ),
          ],
        ),
        ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.challenges.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ChallengeDetailPage(
                    difficulty: 'Easy',
                    categories: ["Food", "Home"],
                    player: widget.player,
                    challenge: widget.challenges[index],
                    isDaily: true,
                  );
                }));
                setState(() {
                  getData();
                });
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade100.withOpacity(0.8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.challenges[index].name,
                          overflow: TextOverflow.ellipsis,
                          softWrap:
                              false, // Set to false to prevent wrapping to a new line
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            decoration:
                                completed.contains(widget.challenges[index].id)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "200 pts",
                            style: GoogleFonts.poppins(
                              color: Colors.green.shade900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 30,
                            child: Icon(
                              Icons.check,
                              color: Colors.green.shade900,
                              size: completed
                                      .contains(widget.challenges[index].id)
                                  ? 20
                                  : 0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            );
          },
        )
      ],
    );
  }
}
