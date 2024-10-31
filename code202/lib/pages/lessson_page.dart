/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-24 21:04:15
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 20:46:12
/// @FilePath: lib/pages/lessson_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'dart:convert';

import 'package:code202/fonts/custom_fonts.dart';
import 'package:code202/models/lessons.dart';
import 'package:code202/models/sub_lessons.dart';
import 'package:code202/widgets/lesson_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/player.dart';
import '../models/stats.dart';

class LesssonPage extends StatefulWidget {
  const LesssonPage({super.key});

  @override
  State<LesssonPage> createState() => _LesssonPageState();
}

class _LesssonPageState extends State<LesssonPage> {
  List<Lessons> lessons = [];

  Player player = Player(
      username: "",
      rank: "",
      xp: 0,
      level: 0,
      health: 0,
      coins: 0,
      co2Saved: 0,
      uid: '',
      completedChallenges: [],
      completedLessons: [],
      completedQuiz: [],
      profileAvatar: '');

  Stats stats = Stats(
      intLevel: 1,
      intXp: 0,
      awrLevel: 1,
      awrXp: 0,
      strLevel: 1,
      strXp: 0,
      resLevel: 1,
      resXp: 0,
      devLevel: 1,
      devXp: 0);

  void getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      stats = Stats.fromSharedPreferences(prefs);
      player = Player.fromSharedPreferences(prefs);
    });
  }

  void getLessons() async {
    final String jsonString =
        await rootBundle.loadString('assets/lessons.json');

    // Decode the JSON string into a List of dynamic objects
    final jsonData = List<Map<String, dynamic>>.from(json.decode(jsonString));
    print(jsonData);
    final lessonsList = jsonData.map((e) => Lessons.fromMap(e)).toList();
    print(lessonsList);
    // print(challenges);
    setState(() {
      lessons = lessonsList;
    });
    // Convert the List of dynamic objects into a List of Challenge objects
  }

  @override
  void initState() {
    // TODO: implement initState
    getProfile();
    getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green.shade100),
                  child: Icon(CupertinoIcons.book_solid,
                      color: Colors.green.shade700, size: 24)),
              SizedBox(
                height: 10,
              ),
              Text(
                "Lessons",
                style: CustomFonts().primary_text,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Obtain more knowledge on climate change and level up your stats",
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${player.completedQuiz.length}",
                            style: GoogleFonts.poppins(
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                          Text(
                            "Lessons Completed",
                            style: GoogleFonts.poppins(
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${player.completedQuiz.length}",
                            style: GoogleFonts.poppins(
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                          Text(
                            "Quiz Passed",
                            style: GoogleFonts.poppins(
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: lessons.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: LessonTileWidget(
                        lesson: lessons[index].name,
                        fullLesson: lessons[index],
                        player: player,
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
