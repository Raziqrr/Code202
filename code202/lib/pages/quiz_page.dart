/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-30 12:15:38
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 20:58:24
/// @FilePath: lib/pages/quiz_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/fonts/custom_fonts.dart';
import 'package:code202/models/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/player.dart';

class QuizPage extends StatefulWidget {
  const QuizPage(
      {super.key,
      required this.quiz,
      required this.player,
      required this.lessonId,
      required this.lessonName});
  final Quiz quiz;
  final Player player;
  final String lessonId;
  final String lessonName;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentHealthBar = 3;
  int currentQuestionIndex = 0;
  int correct = 0;
  String currentAnswer = "";

  @override
  void initState() {
    // TODO: implement initState
    currentHealthBar = widget.quiz.questions.length;
    super.initState();
  }

  void answerQuestion(BuildContext context) {
    if (currentAnswer ==
        widget.quiz.questions[currentQuestionIndex].correctAnswer) {
      correct += 1;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      ),
                      decoration: BoxDecoration(
                          color: CupertinoColors.activeGreen,
                          borderRadius: BorderRadius.circular(100)),
                      padding: EdgeInsets.all(10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Correct Answer",
                      style: GoogleFonts.poppins(
                          color: CupertinoColors.systemGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ).then((_) {
        proceedToNextQuestion(
            context); // Proceed only after user sees the dialog
      });
    } else {
      currentHealthBar -= 1;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Wrong Answer",
                        style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Correct Answer",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.quiz.questions[currentQuestionIndex].correctAnswer,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ).then((_) {
        proceedToNextQuestion(
            context); // Proceed only after user sees the dialog
      });
    }
  }

  void proceedToNextQuestion(BuildContext context) async {
    print(currentHealthBar);
    setState(() {
      currentAnswer = ""; // Clear current answer
      correct;
      currentHealthBar;
    });

    if (currentQuestionIndex + 1 == widget.quiz.questions.length) {
      if (!widget.player.completedLessons.contains(widget.lessonId) &&
          correct == widget.quiz.questions.length) {
        widget.player.completedLessons.add(widget.lessonId);
        widget.player.completedQuiz.add(widget.quiz.id);
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList('completedLessons', widget.player.completedLessons);
        prefs.setStringList('completedQuiz', widget.player.completedQuiz);
        widget.player.addLessonXpAndLevel(widget.lessonName, 70);
      }
      // Show result before navigating
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      correct != widget.quiz.questions.length
                          ? "Failed"
                          : "Passed",
                      style: GoogleFonts.poppins(
                          color: correct != widget.quiz.questions.length
                              ? Colors.red
                              : CupertinoColors.systemGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${correct}/${widget.quiz.questions.length}",
                      style: CustomFonts().primary_text,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      );
    } else {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    answerQuestion(context);
                  },
                  child: Text("Answer")),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: List.generate(widget.quiz.questions.length, (index) {
                return Icon(
                  CupertinoIcons.heart_fill,
                  color: currentHealthBar > index ? Colors.red : Colors.grey,
                );
              }),
            ),
            List.generate(widget.quiz.questions.length, (index) {
              return Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    widget.quiz.questions[index].questionTitle,
                    style: CustomFonts().primary_text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: List.generate(
                        widget.quiz.questions[index].answerChoices.length,
                        (index2) {
                      return RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            widget.quiz.questions[index].answerChoices[index2],
                            style: CustomFonts().paragraph_text,
                          ),
                          value: widget
                              .quiz.questions[index].answerChoices[index2],
                          groupValue: currentAnswer,
                          onChanged: (value) {
                            if (value != null) {
                              currentAnswer = widget
                                  .quiz.questions[index].answerChoices[index2];
                              setState(() {});
                            }
                          });
                    }),
                  )
                ],
              );
            })[currentQuestionIndex]
          ],
        ),
      ),
    );
  }
}
