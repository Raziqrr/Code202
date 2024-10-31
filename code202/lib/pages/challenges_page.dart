import 'package:code202/fonts/custom_fonts.dart';
import 'package:code202/models/challenge.dart';
import 'package:code202/models/player.dart';
import 'package:code202/models/stats.dart';
import 'package:code202/widgets/challenges_widget.dart';
import 'package:code202/widgets/saved_challenges_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/challenge_manager.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({
    super.key,
    required this.stats,
    required this.player,
    required this.challenges,
  });

  final Stats stats;
  final Player player;
  final List<Challenge> challenges;

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 500),
    );
  }

  // Fetch today's challenges
  Future<List<Challenge>> getDailyChallenges() async {
    prefs = await SharedPreferences.getInstance();
    final challengeManager = ChallengeManager(allChallenges: widget.challenges);
    return await challengeManager.getDailyChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Challenges",
          style: CustomFonts().primary_text,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder<List<Challenge>>(
            future: getDailyChallenges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the data is loading, show a loading indicator
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If there was an error fetching the challenges
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // Data has been successfully fetched
                final todayChallenges = snapshot.data!;
                return ChallengesWidget(
                  stats: widget.stats,
                  player: widget.player,
                  challenges: widget.challenges,
                  dailyChallenges: todayChallenges,
                  prefs: prefs,
                );
              } else {
                // No data returned
                return Center(child: Text('No challenges available.'));
              }
              (() {});
            },
          ),
        ),
      ),
    );
  }
}
