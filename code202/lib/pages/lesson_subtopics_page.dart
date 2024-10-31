/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-24 22:20:19
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-30 20:49:13
/// @FilePath: lib/pages/lesson_subtopics_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/models/lessons.dart';
import 'package:code202/pages/sublessons_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/custom_colors.dart';
import '../models/player.dart';

class LessonSubtopicsPage extends StatefulWidget {
  const LessonSubtopicsPage(
      {super.key, required this.lesson, required this.player});
  final Lessons lesson;
  final Player player;

  @override
  State<LessonSubtopicsPage> createState() => _LessonSubtopicsPageState();
}

class _LessonSubtopicsPageState extends State<LessonSubtopicsPage> {
  Color getLessonTileColor(String lesson) {
    switch (lesson.toLowerCase()) {
      case "intelligence":
        return CustomColors().intelligence_blue;
      case "awareness":
        return CustomColors().awareness_green;
      case "strength":
        return CustomColors().strength_red;
      case "resilience":
        return CustomColors().resilience_orange;
      default:
        return CustomColors().devotion_pink;
    }
  }

  Icon getLessonIcon(String lesson) {
    switch (lesson.toLowerCase()) {
      case "intelligence":
        return Icon(
          Icons.school,
          color: CustomColors().intelligence_blue,
          size: 50,
        );
      case "awareness":
        return Icon(
          CupertinoIcons.eye_fill,
          color: CustomColors().awareness_green,
          size: 50,
        );
      case "strength":
        return Icon(
          Icons.fitness_center,
          color: CustomColors().strength_red,
          size: 50,
        );
      case "resilience":
        return Icon(
          CupertinoIcons.shield_fill,
          color: CustomColors().resilience_orange,
          size: 50,
        );
      default:
        return Icon(Icons.warning_rounded);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            getLessonIcon(widget.lesson.name),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.lesson.name,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              children: List.generate(widget.lesson.sublessons.length, (index) {
                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return SublessonsPage(
                        sublessons: widget.lesson.sublessons[index],
                        player: widget.player,
                        lessonName: widget.lesson.name,
                      );
                    }));
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: getLessonTileColor(widget.lesson.name)
                            .withOpacity(0.2)),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.lesson.sublessons[index].title,
                              softWrap: true,
                              style: GoogleFonts.poppins(
                                  color: getLessonTileColor(widget.lesson.name),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: widget.player.completedLessons
                                          .contains(widget
                                              .lesson.sublessons[index].id)
                                      ? Colors.green.shade700
                                      : Colors.grey),
                              child: widget.player.completedLessons.contains(
                                      widget.lesson.sublessons[index].id)
                                  ? Text(
                                      "Finished",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    )
                                  : Text(
                                      "Not done",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                            )
                          ],
                        ),
                        Icon(
                          CupertinoIcons.right_chevron,
                          size: 30,
                          color: getLessonTileColor(widget.lesson.name),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
