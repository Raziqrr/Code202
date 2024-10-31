import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code202/models/friend.dart';
import 'package:code202/models/rank_and_level_system.dart';
import 'package:code202/models/stats.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-28 16:08:19
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 19:02:30
/// @FilePath: lib/models/player.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class Player {
  String uid;
  String username;
  String rank;
  int xp;
  int level;
  int health;
  int coins;
  double co2Saved;
  List<Friend> friends;
  List<String> badges;
  String token;
  List<String> completedChallenges;
  List<String> completedLessons;
  List<String> completedQuiz;
  String profileAvatar;
  List<String> unlockedProfiles;

  Player(
      {required this.username,
      required this.rank,
      required this.xp,
      required this.level,
      required this.health,
      required this.coins,
      required this.co2Saved,
      this.friends = const [],
      required this.uid,
      this.badges = const [],
      required this.completedChallenges,
      required this.completedLessons,
      required this.completedQuiz,
      required this.profileAvatar,
      this.unlockedProfiles = const ["little sapling"],
      this.token = ""});

  factory Player.fromSharedPreferences(SharedPreferences prefs) {
    // Define default values
    const String defaultUsername = 'Little Sapling';
    const String defaultRank = 'Beginner';
    const int defaultXp = 0;
    const int defaultLevel = 1;
    const int defaultHealth = 100;
    const int defaultCoins = 0;
    const int defaultCo2Saved = 0;
    const List<String> defaultFriendsId = [];
    const List<String> defaultBadges = [];
    const String defaultUid = "";
    const List<String> completedChallenges = [];

    // Load values from SharedPreferences, or use defaults and save them if not present
    String username = prefs.getString('username') ?? defaultUsername;
    if (prefs.getString('username') == null) {
      prefs.setString('username', defaultUsername);
    }

    String profileAvatar =
        prefs.getString('profileAvatar') ?? "assets/images/leaf_character.jpg";
    if (prefs.getString('profileAvatar') == null) {
      prefs.setString('profileAvatar', "assets/images/leaf_character.jpg");
    }

    String rank = prefs.getString('rank') ?? defaultRank;
    if (prefs.getString('rank') == null) {
      prefs.setString('rank', defaultRank);
    }

    int xp = prefs.getInt('xp') ?? defaultXp;
    if (prefs.getInt('xp') == null) {
      prefs.setInt('xp', defaultXp);
    }

    int level = prefs.getInt('level') ?? defaultLevel;
    if (prefs.getInt('level') == null) {
      prefs.setInt('level', defaultLevel);
    }

    int health = prefs.getInt('health') ?? defaultHealth;
    if (prefs.getInt('health') == null) {
      prefs.setInt('health', defaultHealth);
    }

    int coins = prefs.getInt('coins') ?? defaultCoins;
    if (prefs.getInt('coins') == null) {
      prefs.setInt('coins', defaultCoins);
    }

    double co2Saved = double.parse(prefs.getString('co2Saved') ?? "0.0");
    if (prefs.getString('co2Saved') == null) {
      prefs.setString('co2Saved', "0.0");
    }
    final friendsJson = prefs.getString("friends");

    List<Friend> gotFriends = [];
    if (friendsJson != null && friendsJson.isNotEmpty) {
      // If friendsJson is valid, decode it and map to Friend list
      gotFriends = (jsonDecode(friendsJson) as List)
          .map((e) => Friend.fromMap(e))
          .toList();
    } else {
      // If friendsJson is null, initialize with defaultFriendsId
      prefs.setString('friends', "");
    }

    List<String> badges = prefs.getStringList('friendsId') ?? [];
    if (prefs.getStringList('badges') == null) {
      prefs.setStringList('badges', badges);
    }

    List<String> cChallenges = prefs.getStringList('completedChallenges') ?? [];
    if (prefs.getStringList('completedChallenges') == null) {
      prefs.setStringList('completedChallenges', cChallenges);
    }

    String uid = prefs.getString('uid') ?? defaultUid;
    if (prefs.getString("uid") == null) {
      prefs.setString("uid", uid);
    }

    String token = prefs.getString('token') ?? "";
    if (prefs.getString("token") == null) {
      prefs.setString("token", "");
    }

    List<String> cLessons = prefs.getStringList('completedLessons') ?? [];
    if (prefs.getStringList('completedLessons') == null) {
      prefs.setStringList('completedLessons', []);
    }
    List<String> uProfiles =
        prefs.getStringList('unlockedProfiles') ?? ["Little Leaf"];
    if (prefs.getStringList('unlockedProfiles') == null) {
      prefs.setStringList('unlockedProfiles', ["Little Leaf"]);
    }

    List<String> cQuiz = prefs.getStringList('completedQuiz') ?? [];
    if (prefs.getStringList('completedQuiz') == null) {
      prefs.setStringList('completedQuiz', []);
    }

    return Player(
        username: username,
        rank: rank,
        xp: xp,
        level: level,
        health: health,
        coins: coins,
        co2Saved: co2Saved,
        friends: gotFriends,
        badges: badges,
        uid: uid,
        token: token,
        completedChallenges: cChallenges,
        completedLessons: cLessons,
        completedQuiz: cQuiz,
        profileAvatar: profileAvatar,
        unlockedProfiles: uProfiles);
  }

  void setUsername(String newName) {
    this.username = newName;
    saveDataString('username', username);
  }

  void setRank(String newRank) {}

  void setXp(int newXp) {}

  void addXp(int xp) {}

  void setLevel(int newLevel) {}

  void increaseLevel() {}

  void setHealth(int newHealth) {}

  void healHealth(int healAmount) {}

  int dealDamage(double damage) {
    int newDamage = int.parse("${damage.toStringAsFixed(0)}");
    if (newDamage < 1) {
      newDamage = 1;
    }

    health -= newDamage;
    if (health < 0) {
      health = 0;
    }
    saveDataInt("health", health);

    return newDamage;
  }

  void setCoins(int newCoins) {}

  void addCoins(int coinAmount) {}

  void spendCoins(int price) {}

  void setCo2Saved(int co2Amount) {}

  void addCo2Saved(int co2Amount) {}

  void setUid(String newUid) {
    this.uid = newUid;
    saveDataString('uid', uid);
  }

  void setToken(String newToken) {
    this.token = newToken;
    saveDataString('token', token);
  }

  void saveDataString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  void saveDataStringList(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  void saveDataInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  void addBadges(String badge) {
    this.badges.add(badge);
    saveDataStringList('badges', badges);
  }

  void completeChallenge(String challengeId) {
    this.completedChallenges.add(challengeId);
    saveDataStringList('completedChallenges', completedChallenges);
  }

  void resetChallenge(String challengeId) {
    this.completedChallenges.remove(challengeId);
    saveDataStringList('completedChallenges', completedChallenges);
  }

  void equipAvatar(String path) {
    profileAvatar = path;
    saveDataString('profileAvatar', profileAvatar);
  }

  void buyAvatar(String name, String path, int price, BuildContext context) {
    if (unlockedProfiles.contains(name)) {
      profileAvatar = path;
      saveDataString('profileAvatar', profileAvatar);
    }
    if (coins >= price && !unlockedProfiles.contains(name)) {
      coins -= price;
      saveDataInt('coins', coins);

      unlockedProfiles.add(name);
      saveDataStringList('unlockedProfiles', unlockedProfiles);

      profileAvatar = path;
      saveDataString('profileAvatar', profileAvatar);

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(CupertinoIcons.money_dollar_circle_fill),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Bought ${name} Avatar"),
                    ],
                  ),
                )
              ],
            );
          });
    } else if (coins < price && !unlockedProfiles.contains(name)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(CupertinoIcons.money_dollar_circle_fill),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Not enough coins"),
                    ],
                  ),
                )
              ],
            );
          });
    }
  }

  void addChallengeCompleteStats(
      int newCoins, int devXp, int newXp, int newHealth, double newCo2) async {
    final prefs = await SharedPreferences.getInstance();
    final stats = Stats.fromSharedPreferences(prefs);
    final levelCap = Rank().getLevelCap(level);
    stats.devXp += devXp;
    if (stats.devXp >= 100) {
      stats.devXp -= 100;
      stats.devLevel++;
    }
    co2Saved += newCo2;
    xp += newXp;
    coins += newCoins;
    if (xp >= levelCap) {
      xp -= levelCap;
      level++;
    }

    health += newHealth;
    if (health > 100) {
      health = 100;
    }
    saveDataInt('xp', xp);
    saveDataInt('coins', coins);
    saveDataInt('health', health);
    saveDataInt('level', level);
    saveDataInt('devLevel', stats.devLevel);
    saveDataInt('devXp', stats.devXp);
    saveDataString("co2Saved", co2Saved.toString());
  }

  void addLessonXpAndLevel(String lessonCategory, int newXp) async {
    print("Adding ${lessonCategory} xp");
    final prefs = await SharedPreferences.getInstance();
    final stats = Stats.fromSharedPreferences(prefs);

    // Update overall user XP and level
    final levelCap = Rank().getLevelCap(level);
    xp += newXp;
    if (xp >= levelCap) {
      xp -= levelCap;
      level++;
    }
    print("Current xp ${xp}");
    print("Current level cap ${levelCap}");
    print("Current level ${level}");

    // Update lesson-specific XP and level
    switch (lessonCategory.toLowerCase()) {
      case 'intelligence':
        stats.intXp += newXp;
        if (stats.intXp >= 100) {
          stats.intXp -= 100;
          stats.intLevel++;
        }
        break;
      case 'awareness':
        stats.awrXp += newXp;
        if (stats.awrXp >= 100) {
          stats.awrXp -= 100;
          stats.awrLevel++;
        }
        break;
      case 'strength':
        stats.strXp += newXp;
        if (stats.strXp >= 100) {
          stats.strXp -= 100;
          stats.strLevel++;
        }
        break;
      case 'resilience':
        stats.resXp += newXp;
        if (stats.resXp >= 100) {
          stats.resXp -= 100;
          stats.resLevel++;
        }
        break;
      default:
        print("Unknown lesson category: $lessonCategory");
        return;
    }

    // Save the updated XP and levels
    saveDataInt('xp', xp);
    saveDataInt('level', level);

    // Save the specific attribute levels and XP
    saveDataInt('intLevel', stats.intLevel);
    saveDataInt('intXp', stats.intXp);
    saveDataInt('awrLevel', stats.awrLevel);
    saveDataInt('awrXp', stats.awrXp);
    saveDataInt('strLevel', stats.strLevel);
    saveDataInt('strXp', stats.strXp);
    saveDataInt('resLevel', stats.resLevel);
    saveDataInt('resXp', stats.resXp);
  }

  void addFriend(String uid) async {
    try {
      // Reference to Firestore
      final firestore = FirebaseFirestore.instance;

      // Get friend data from 'users' collection
      final friendSnapshot =
          await firestore.collection('ClimateUsers').doc(uid).get();

      if (friendSnapshot.exists) {
        // Extract friend's name and token from the document
        final friendData = friendSnapshot.data();
        final friendName = friendData?['name'].toString();
        final friendToken = friendData?['token'].toString();

        if (friendName == null || friendToken == null) {
          print("Friend data incomplete.");
          return;
        }

        friends.add(Friend(name: friendName, uid: uid, token: friendToken));
        saveDataString(
            "friends", jsonEncode(friends.map((e) => e.toMap()).toList()));

        print("Friend added successfully!");
        print(friends.first.uid);
      } else {
        print("Friend not found.");
      }
    } catch (error) {
      print("Error adding friend: $error");
    }
  }
}
