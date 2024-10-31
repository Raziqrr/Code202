/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-24 21:59:49
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-30 20:42:22
/// @FilePath: lib/widgets/lesson_tile_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/colors/custom_colors.dart';
import 'package:code202/models/lessons.dart';
import 'package:code202/models/sub_lessons.dart';
import 'package:code202/pages/lesson_subtopics_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/player.dart';

class LessonTileWidget extends StatefulWidget {
  const LessonTileWidget(
      {super.key,
      required this.lesson,
      required this.fullLesson,
      required this.player});
  final String lesson;
  final Lessons fullLesson;
  final Player player;

  @override
  State<LessonTileWidget> createState() => _LessonTileWidgetState();
}

class _LessonTileWidgetState extends State<LessonTileWidget> {
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
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: getLessonTileColor(widget.lesson).withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return LessonSubtopicsPage(
              lesson: widget.fullLesson,
              player: widget.player,
            );
          }));
          setState(() {
            widget.lesson;
            widget.player;
          });
        },
        splashColor: getLessonTileColor(widget.lesson).withOpacity(0.7),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.lesson,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: getLessonTileColor(widget.lesson)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                            "Discover the meaning of swimming", //this texxt
                            softWrap: true,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: getLessonTileColor(widget.lesson))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.player.completedLessons.where((completedLesson) => widget.fullLesson.sublessons.map((e) => e.id).toList().contains(completedLesson)).length}/${widget.fullLesson.sublessons.length} Completed",
                        style: GoogleFonts.poppins(
                            shadows: [
                              Shadow(
                                color: Colors.white.withOpacity(0.5),
                                blurRadius: 1,
                              ),
                            ],
                            color: getLessonTileColor(widget.lesson)
                                .withOpacity(0.7),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  getLessonIcon(widget.lesson),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    CupertinoIcons.right_chevron,
                    color: getLessonTileColor(widget.lesson),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
