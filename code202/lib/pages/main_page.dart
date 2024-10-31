/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-24 20:45:07
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-30 21:07:01
/// @FilePath: lib/pages/main_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'dart:convert';

import 'package:code202/colors/custom_colors.dart';
import 'package:code202/models/challenge.dart';
import 'package:code202/models/emissions.dart';
import 'package:code202/models/stats.dart';
import 'package:code202/pages/challenges_page.dart';
import 'package:code202/pages/home_page.dart';
import 'package:code202/pages/lessson_page.dart';
import 'package:code202/pages/profile_page.dart';
import 'package:code202/widgets/custom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/player.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<BottomNavigationBarItem> navigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.book_solid), label: "Lessons"),
    BottomNavigationBarItem(
        icon: Icon(Icons.emoji_events_rounded), label: "Challenges"),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: "Profile"),
  ];

  int currentIndex = 0;

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

  List<Challenge> challenges = [];

  Emissions emissions = Emissions(home: 0, transport: 0, food: 0, stuff: 0);

  void initializeNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    print('User granted permission: ${settings.authorizationStatus}');
  }

  void getChallenges() async {
    final String jsonString =
        await rootBundle.loadString('assets/challenges.json');

    // Decode the JSON string into a List of dynamic objects
    final jsonData = List<Map<String, dynamic>>.from(json.decode(jsonString));
    print(jsonData);
    final challengeList = jsonData.map((e) => Challenge.fromMap(e)).toList();
    print(challengeList);
    // print(challenges);
    setState(() {
      challenges = challengeList;
    });
    // Convert the List of dynamic objects into a List of Challenge objects
  }

  void getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (player.token == "") {
      try {
        String? token = await FirebaseMessaging.instance.getToken();
        print('Firebase Token: $token');
        if (token != null) {
          setState(() {
            player.setToken(token);
          });
        }
      } catch (e) {
        print('Error retrieving Firebase Token: $e');
      }
    }
    setState(() {
      emissions = Emissions.fromSharedPreferences(prefs);
      stats = Stats.fromSharedPreferences(prefs);
      player = Player.fromSharedPreferences(prefs);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initializeNotifications();
    getProfile();
    getChallenges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: CustomColors().snow_white,
          unselectedItemColor: Colors.green.shade200,
          unselectedIconTheme: IconThemeData(size: 24),
          selectedIconTheme: IconThemeData(size: 30),
          selectedItemColor: Colors.green.shade600,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: navigationItems),
      body: [
        HomePage(
          player: player,
          emissions: emissions,
          challenges: challenges,
        ),
        LesssonPage(),
        ChallengesPage(
          stats: stats,
          player: player,
          challenges: challenges,
        ),
        ProfilePage(
          player: player,
          stats: stats,
        )
      ][currentIndex],
    );
  }
}
