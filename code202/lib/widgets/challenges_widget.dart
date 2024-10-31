/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-23 19:29:37
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 17:22:11
/// @FilePath: lib/widgets/challenges_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/fonts/custom_fonts.dart';
import 'package:code202/models/player.dart';
import 'package:code202/models/stats.dart';
import 'package:code202/widgets/challenge_progress_widget.dart';
import 'package:code202/widgets/minimized_challenge_widget.dart';
import 'package:date_format/date_format.dart';
import 'package:emoji_data/emoji_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/challenge.dart';
import '../pages/challenge_detail_page.dart';

class ChallengesWidget extends StatefulWidget {
  const ChallengesWidget(
      {super.key,
      required this.stats,
      required this.player,
      required this.challenges,
      required this.dailyChallenges,
      required this.prefs});
  final Stats stats;
  final Player player;
  final List<Challenge> challenges;
  final List<Challenge> dailyChallenges;
  final SharedPreferences prefs;

  @override
  State<ChallengesWidget> createState() => _ChallengesWidgetState();
}

class _ChallengesWidgetState extends State<ChallengesWidget> {
  late ExpansionTileController dailyTileController;
  late ExpansionTileController easyTileController;
  late ExpansionTileController mediumTileController;
  late ExpansionTileController hardTileController;

  List<Challenge> easyChallenges = [];
  List<Challenge> mediumChallenges = [];
  List<Challenge> hardChallenges = [];

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

  void allocateChallenges() {
    setState(() {
      easyChallenges = [];
      mediumChallenges = [];
      hardChallenges = [];
      widget.dailyChallenges;
      widget.challenges.forEach((challenge) {
        if (challenge.difficulty == "Easy") {
          easyChallenges.add(challenge);
        } else if (challenge.difficulty == "Medium") {
          mediumChallenges.add(challenge);
        } else if (challenge.difficulty == "Hard") {
          hardChallenges.add(challenge);
        }
      });
    });
  }

  List<String> completed = [];

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    completed = prefs.getStringList("completedDailies") ?? [];
    setState(() {});
    print(completed);
    print("Checking completed");
  }

  @override
  void initState() {
    // TODO: implement initState
    dailyTileController = ExpansionTileController();
    easyTileController = ExpansionTileController();
    mediumTileController = ExpansionTileController();
    hardTileController = ExpansionTileController();
    getData();
    allocateChallenges();
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChallengeProgressWidget(
          stats: stats,
          player: player,
          challenges: widget.challenges,
        ),
        SizedBox(
          height: 20,
        ),
        Autocomplete(
          fieldViewBuilder: (context, controller, focusnode, onSubmit) {
            return TextField(
              onTapOutside: (event) {
                focusnode.unfocus();
              },
              focusNode: focusnode,
              controller: controller,
              style: GoogleFonts.poppins(
                  decoration: TextDecoration.none,
                  color: Colors.green,
                  fontWeight: FontWeight.w500),
              cursorColor: Colors.green,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.green.withOpacity(0.2),
                  hintText: "Search Challenge",
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.green, fontWeight: FontWeight.w500)),
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            final newList = widget.challenges.map((c) => c.name).toList();
            final resultList = newList.where((e) {
              return e
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            }).toList();
            return resultList;
          },
        ),
        SizedBox(
          height: 30,
        ),
        ExpansionTile(
          iconColor: Colors.pink,
          collapsedIconColor: Colors.pink.shade300,
          onExpansionChanged: (opened) {
            if (opened) {
              dailyTileController.expand();
              easyTileController.collapse();
              mediumTileController.collapse();
              hardTileController.collapse();
            } else {
              dailyTileController.collapse();
            }
            setState(() {});
          },
          shape: Border.all(color: Colors.transparent, width: 0),
          controller: dailyTileController,
          tilePadding: EdgeInsets.zero,
          title: Row(
            children: [
              Text(
                "Daily",
                style: CustomFonts().challengesFontCustomColor(Colors.pink),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.change_circle),
              SizedBox(
                width: 10,
              ),
              Text(
                "${completed.length}/3",
                style: CustomFonts()
                    .challengesFontCustomColor2(Colors.pink.withOpacity(0.7)),
              )
            ],
          ),
          children: List.generate(widget.dailyChallenges.length, (index) {
            print(widget.dailyChallenges[index].name);
            setState(() {
              widget.dailyChallenges;
            });
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ChallengeDetailPage(
                    difficulty: widget.dailyChallenges[index].difficulty,
                    categories: widget.dailyChallenges[index].categories,
                    player: player,
                    challenge: widget.dailyChallenges[index],
                    isDaily: true,
                  );
                }));
                print(widget.player.xp);
                print("xp");
                setState(() {
                  getProfile();
                  getData();
                });
              },
              child: MinimizedChallengeWidget(
                color: Colors.pink.shade100,
                textColor: Colors.pink,
                difficulty: widget.dailyChallenges[index].difficulty,
                categories: widget.dailyChallenges[index].categories,
                player: player,
                challenge: widget.dailyChallenges[index],
                isDaily: true,
                prefs: widget.prefs,
              ),
            );
          }),
        ),
        ExpansionTile(
          iconColor: Colors.green,
          collapsedIconColor: Colors.green.shade300,
          shape: Border.all(color: Colors.transparent, width: 0),
          tilePadding: EdgeInsets.zero,
          onExpansionChanged: (opened) {
            if (opened) {
              easyTileController.expand();
              mediumTileController.collapse();
              hardTileController.collapse();
              dailyTileController.collapse();
            } else {
              easyTileController.collapse();
            }
            setState(() {});
          },
          controller: easyTileController,
          title: Row(
            children: [
              Text(
                "Easy",
                style: CustomFonts().challengesFontCustomColor(Colors.green),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.star),
              SizedBox(
                width: 10,
              ),
              Text(
                "${player.completedChallenges.where((e) {
                      return easyChallenges
                          .map((e) => e.id)
                          .toList()
                          .contains(e);
                    }).toList().length}/${easyChallenges.length}",
                style: CustomFonts()
                    .challengesFontCustomColor2(Colors.green.withOpacity(0.7)),
              )
            ],
          ),
          children: List.generate(easyChallenges.length, (index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ChallengeDetailPage(
                    difficulty: "Easy",
                    categories: easyChallenges[index].categories,
                    player: player,
                    challenge: easyChallenges[index],
                    isDaily: false,
                  );
                }));
                print(widget.player.xp);
                print("xp");
                setState(() {
                  getProfile();
                  getData();
                });
              },
              child: MinimizedChallengeWidget(
                color: Colors.green.shade100,
                textColor: Colors.green.shade900,
                difficulty: "Easy",
                categories: easyChallenges[index].categories,
                player: player,
                challenge: easyChallenges[index],
                isDaily: false,
                prefs: widget.prefs,
              ),
            );
          }),
        ),
        ExpansionTile(
          iconColor: Colors.orange,
          collapsedIconColor: Colors.orange.shade200,
          shape: Border.all(color: Colors.transparent, width: 0),
          tilePadding: EdgeInsets.zero,
          onExpansionChanged: (opened) {
            if (opened) {
              mediumTileController.expand();
              dailyTileController.collapse();
              easyTileController.collapse();
              hardTileController.collapse();
            } else {
              mediumTileController.collapse();
            }
            setState(() {});
          },
          controller: mediumTileController,
          title: Row(
            children: [
              Text(
                "Medium",
                style: CustomFonts().challengesFontCustomColor(Colors.orange),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.star),
              Icon(Icons.star),
              SizedBox(
                width: 10,
              ),
              Text(
                "${player.completedChallenges.where((e) {
                      return mediumChallenges
                          .map((e) => e.id)
                          .toList()
                          .contains(e);
                    }).toList().length}/${mediumChallenges.length}",
                style: CustomFonts()
                    .challengesFontCustomColor2(Colors.orange.withOpacity(0.7)),
              )
            ],
          ),
          children: List.generate(mediumChallenges.length, (index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ChallengeDetailPage(
                    difficulty: "Medium",
                    categories: mediumChallenges[index].categories,
                    player: player,
                    challenge: mediumChallenges[index],
                    isDaily: false,
                  );
                }));
                print(widget.player.xp);
                print("xp");
                setState(() {
                  getProfile();
                  getData();
                });
              },
              child: MinimizedChallengeWidget(
                color: Colors.orange.shade100,
                textColor: Colors.orange.shade900,
                difficulty: "Medium",
                categories: mediumChallenges[index].categories,
                player: player,
                challenge: mediumChallenges[index],
                isDaily: false,
                prefs: widget.prefs,
              ),
            );
          }),
        ),
        ExpansionTile(
          iconColor: Colors.red.shade700,
          collapsedIconColor: Colors.red.shade200,
          shape: Border.all(color: Colors.transparent, width: 0),
          tilePadding: EdgeInsets.zero,
          onExpansionChanged: (opened) {
            if (opened) {
              hardTileController.expand();
              dailyTileController.collapse();
              easyTileController.collapse();
              mediumTileController.collapse();
            } else {
              hardTileController.collapse();
            }
          },
          controller: hardTileController,
          title: Row(
            children: [
              Text(
                "Hard",
                style: CustomFonts()
                    .challengesFontCustomColor(Colors.red.shade700),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.star),
              Icon(Icons.star),
              Icon(Icons.star),
              SizedBox(
                width: 10,
              ),
              Text(
                "${player.completedChallenges.where((e) {
                      return hardChallenges
                          .map((e) => e.id)
                          .toList()
                          .contains(e);
                    }).toList().length}/${hardChallenges.length}",
                style: CustomFonts().challengesFontCustomColor2(
                    Colors.red.shade700.withOpacity(0.7)),
              )
            ],
          ),
          children: List.generate(hardChallenges.length, (index) {
            return GestureDetector(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ChallengeDetailPage(
                    difficulty: "Hard",
                    categories: hardChallenges[index].categories,
                    player: player,
                    challenge: hardChallenges[index],
                    isDaily: false,
                  );
                }));
                print(widget.player.xp);
                print("xp");
                setState(() {
                  getData();
                  getProfile();
                });
              },
              child: MinimizedChallengeWidget(
                color: Colors.red.shade100,
                textColor: Colors.red.shade900,
                difficulty: "Hard",
                categories: hardChallenges[index].categories,
                player: player,
                challenge: hardChallenges[index],
                isDaily: false,
                prefs: widget.prefs,
              ),
            );
          }),
        )
      ],
    );
  }
}
