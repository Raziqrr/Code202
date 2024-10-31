/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-20 23:19:34
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 20:47:11
/// @FilePath: lib/pages/profile_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/colors/custom_colors.dart';
import 'package:code202/fonts/custom_fonts.dart';
import 'package:code202/widgets/badges_display_widget.dart';
import 'package:code202/widgets/custom_navigation_bar.dart';
import 'package:code202/widgets/maximized_profile_widget.dart';
import 'package:code202/widgets/profile_points_widget.dart';
import 'package:code202/widgets/radar_stats_widget.dart';
import 'package:code202/widgets/stats_guide_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/player.dart';
import '../models/stats.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.player, required this.stats});
  final Player player;
  final Stats stats;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    print(player.unlockedProfiles);
  }

  @override
  void initState() {
    // TODO: implement initState
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              MaximizedProfileWidget(
                player: player,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ProfilePointsWidget(
                    player: player,
                    equipAvatar: (imagePath) {
                      player.profileAvatar = imagePath;
                      setState(() {
                        player;
                        getProfile();
                      });
                      print("image path ${imagePath}");
                      print(player.profileAvatar = imagePath);
                    },
                    buyAvatar: (name, path, price, context) {
                      player.buyAvatar(name, path, price, context);
                      setState(() {
                        player;
                        getProfile();
                      });
                    },
                    updateImage: (imagePath) {
                      player.profileAvatar = imagePath;
                      setState(() {
                        player;
                        getProfile();
                      });
                      print("image path ${imagePath}");
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    "Stats",
                    style: CustomFonts().primary_text,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 300,
                  child: RadarStatsWidget(
                    stats: stats,
                  )),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 200,
                      child: Text(
                        "Intelligence",
                        style: CustomFonts().intelligenceSmall,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Lvl. ${stats.intLevel}",
                        style: CustomFonts().intelligenceSmall,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${stats.intXp}/100 XP",
                        style: GoogleFonts.poppins(
                            color: CustomColors()
                                .intelligence_blue
                                .withOpacity(0.5)),
                      ),
                    ],
                  )
                ],
              ),
              LinearProgressIndicator(
                backgroundColor:
                    CustomColors().intelligence_blue.withOpacity(0.2),
                minHeight: 12,
                borderRadius: BorderRadius.circular(10),
                color: CustomColors().intelligence_blue,
                value: double.parse('${stats.intXp}') / 100,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 200,
                      child: Text(
                        "Awareness",
                        style: CustomFonts().awarenessSmall,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Lvl. ${stats.awrLevel}",
                        style: CustomFonts().awarenessSmall,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${stats.awrXp}/100 XP",
                        style: GoogleFonts.poppins(
                            color: CustomColors()
                                .awareness_green
                                .withOpacity(0.5)),
                      ),
                    ],
                  )
                ],
              ),
              LinearProgressIndicator(
                backgroundColor:
                    CustomColors().awareness_green.withOpacity(0.2),
                minHeight: 12,
                borderRadius: BorderRadius.circular(10),
                color: CustomColors().awareness_green,
                value: double.parse('${stats.awrXp}') / 100,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 200,
                      child: Text(
                        "Strength",
                        style: CustomFonts().strengthSmall,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Lvl. ${stats.strLevel}",
                        style: CustomFonts().strengthSmall,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${stats.strXp}/100 XP",
                        style: GoogleFonts.poppins(
                            color:
                                CustomColors().strength_red.withOpacity(0.5)),
                      ),
                    ],
                  )
                ],
              ),
              LinearProgressIndicator(
                backgroundColor: CustomColors().strength_red.withOpacity(0.2),
                minHeight: 12,
                borderRadius: BorderRadius.circular(10),
                color: CustomColors().strength_red,
                value: double.parse('${stats.strXp}') / 100,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 200,
                      child: Text(
                        "Resilience",
                        style: CustomFonts().resilienceSmall,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Lvl. ${stats.resLevel}",
                        style: CustomFonts().resilienceSmall,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${stats.resXp}/100 XP",
                        style: GoogleFonts.poppins(
                            color: CustomColors()
                                .resilience_orange
                                .withOpacity(0.5)),
                      ),
                    ],
                  )
                ],
              ),
              LinearProgressIndicator(
                backgroundColor:
                    CustomColors().resilience_orange.withOpacity(0.2),
                minHeight: 12,
                borderRadius: BorderRadius.circular(10),
                color: CustomColors().resilience_orange,
                value: double.parse('${stats.resXp}') / 100,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 200,
                      child: Text(
                        "Devotion",
                        style: CustomFonts().devotionSmall,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Lvl. ${stats.devLevel}",
                        style: CustomFonts().devotionSmall,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${stats.devXp}/100 XP",
                        style: GoogleFonts.poppins(
                            color:
                                CustomColors().devotion_pink.withOpacity(0.5)),
                      ),
                    ],
                  )
                ],
              ),
              LinearProgressIndicator(
                backgroundColor: CustomColors().devotion_pink.withOpacity(0.2),
                minHeight: 12,
                borderRadius: BorderRadius.circular(10),
                color: CustomColors().devotion_pink,
                value: double.parse('${stats.devXp}') / 100,
              ),
              SizedBox(
                height: 40,
              ),
              StatsGuideWidget(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
