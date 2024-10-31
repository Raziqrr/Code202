/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-20 23:19:24
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 20:18:07
/// @FilePath: lib/pages/home_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/models/challenge.dart';
import 'package:code202/models/emissions.dart';
import 'package:code202/widgets/custom_navigation_bar.dart';
import 'package:code202/widgets/daily_challenges_widget.dart';
import 'package:code202/widgets/minimized_emissions_widget.dart';
import 'package:code202/widgets/minimized_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/challenge_manager.dart';
import '../models/player.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.player,
      required this.emissions,
      required this.challenges});
  final Player player;
  final Emissions emissions;
  final List<Challenge> challenges;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Challenge>> getDailyChallenges() async {
    final challengeManager = ChallengeManager(allChallenges: widget.challenges);
    return await challengeManager.getDailyChallenges();
  }

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

  void getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      player = Player.fromSharedPreferences(prefs);
    });
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
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: FutureBuilder(
              future: getDailyChallenges(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Challenge>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the data is loading, show a loading indicator
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If there was an error fetching the challenges
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  // Data has been successfully fetched
                  final todayChallenges = snapshot.data!;
                  return Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      // Minimized Profile
                      MinimizedProfileWidget(
                        imagePath: player.profileAvatar,
                        player: player,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Daily Challenges
                      DailyChallengesWidget(
                        player: player,
                        challenges: todayChallenges,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Tracker
                      MinimizedEmissionsWidget(
                        emissions: widget.emissions,
                        dealDamage: (double) {
                          return player.dealDamage(double);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // My friends
                    ],
                  );
                } else {
                  // No data returned
                  return Center(child: Text('No challenges available.'));
                }
              },
            )),
      ),
    );
  }
}
