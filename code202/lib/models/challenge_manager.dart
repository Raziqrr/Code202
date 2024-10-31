import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'challenge.dart';

/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-29 12:44:00
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 17:22:10
/// @FilePath: lib/models/challenge_manager.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class ChallengeManager {
  final List<Challenge> allChallenges; // Pool of all challenges
  final int numberOfDailyChallenges; // Number of daily challenges to show

  ChallengeManager({
    required this.allChallenges,
    this.numberOfDailyChallenges = 3, // Default to 3 challenges per day
  });

  // Generate a unique key for storing daily challenges
  String getDailyChallengesKey(String date) => 'daily_challenges_$date';

  // Fetch the current date as a string (e.g., "2024-10-28")
  String getCurrentDateString() {
    final now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now); // Format date as a string
  }

  // Generate a random set of challenges with one challenge for each difficulty
  Future<List<Challenge>> generateDailyChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    // Group challenges by difficulty
    final easyChallenges =
        allChallenges.where((c) => c.difficulty == 'Easy').toList();
    final mediumChallenges =
        allChallenges.where((c) => c.difficulty == 'Medium').toList();
    final hardChallenges =
        allChallenges.where((c) => c.difficulty == 'Hard').toList();

    // Ensure there are enough challenges in each category
    if (easyChallenges.isEmpty ||
        mediumChallenges.isEmpty ||
        hardChallenges.isEmpty) {
      throw Exception('Not enough challenges in all difficulty categories.');
    }

    final currentDate = getCurrentDateString();

    // Shuffle each difficulty group
    final random = Random(currentDate.hashCode);
    easyChallenges.shuffle(random);
    mediumChallenges.shuffle(random);
    hardChallenges.shuffle(random);

    // Select one challenge from each category
    return [
      easyChallenges.first,
      mediumChallenges.first,
      hardChallenges.first,
    ];
  }

  Future<void> removePreviousChallenges(String previousDate) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("completedDailies", []);
    await prefs.remove(getDailyChallengesKey(previousDate));
  }

  // Load daily challenges from SharedPreferences or generate new ones if the date has changed
  Future<List<Challenge>> getDailyChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    final currentDate = getCurrentDateString();
    final savedDate = prefs.getString('last_challenge_date');
    // If the saved date matches the current date, return the saved challenges
    if (savedDate != currentDate) {
      prefs.setStringList("completedDailies", []);
    }

    // Otherwise, generate new daily challenges with no duplicates and varying difficulties
    final newChallenges = await generateDailyChallenges();
    // Save the new challenges and update the saved date
    await prefs.setString('last_challenge_date', currentDate);
    await prefs.setStringList(
      getDailyChallengesKey(currentDate),
      newChallenges.map((challenge) => jsonEncode(challenge.toMap())).toList(),
    );

    return newChallenges;
  }
}
