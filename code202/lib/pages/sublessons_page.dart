/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-30 11:21:51
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 17:22:11
/// @FilePath: lib/pages/sublessons_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'dart:convert';

import 'package:code202/fonts/custom_fonts.dart';
import 'package:code202/models/quiz.dart';
import 'package:code202/models/sub_lessons.dart';
import 'package:code202/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/player.dart';

class SublessonsPage extends StatefulWidget {
  const SublessonsPage(
      {super.key,
      required this.sublessons,
      required this.player,
      required this.lessonName});
  final Sublessons sublessons;
  final Player player;
  final String lessonName;

  @override
  State<SublessonsPage> createState() => _SublessonsPageState();
}

class _SublessonsPageState extends State<SublessonsPage> {
  List<Quiz> quizes = [];

  void getQuiz() async {
    final String jsonString = await rootBundle.loadString('assets/quizes.json');

    // Decode the JSON string into a List of dynamic objects
    final jsonData = List<Map<String, dynamic>>.from(json.decode(jsonString));
    final quizList = jsonData.map((e) => Quiz.fromMap(e)).toList();
    // print(challenges);
    setState(() {
      quizes = quizList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getQuiz();
    super.initState();
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
                    onPressed: () async {
                      print(quizes);
                      final String jsonString =
                          await rootBundle.loadString('assets/quizes.json');
                      final jsonData = List<Map<String, dynamic>>.from(
                          json.decode(jsonString));
                      print(jsonData);
                      final quizList =
                          jsonData.map((e) => Quiz.fromMap(e)).toList();

                      print("My quiz id");
                      print(widget.sublessons.quizId);
                      final thisQuiz = quizList[quizes.indexWhere((e) {
                        return e.id == widget.sublessons.quizId;
                      })];

                      await Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return QuizPage(
                          quiz: thisQuiz,
                          player: widget.player,
                          lessonId: widget.sublessons.id,
                          lessonName: widget.lessonName,
                        );
                      }));
                      setState(() {
                        getQuiz();
                      });
                    },
                    child: Text("Answer Quiz"))),
          ],
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.sublessons.title,
                style: CustomFonts().primary_text,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/images/${widget.sublessons.id}.jpg"))),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Description",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.sublessons.lessonDescription,
                style: CustomFonts().paragraph_text,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Contents",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children:
                    List.generate(widget.sublessons.contents.length, (index) {
                  return Text(widget.sublessons.contents[index]);
                }),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Contents",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await launchUrl(
                        Uri.parse(widget.sublessons.references.first["url"]));
                  },
                  child: Text("View More")),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
