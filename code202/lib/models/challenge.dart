import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart'
    as tz; // For initializing the timezone database
import 'package:timezone/timezone.dart' as tz; // For using tz.TZDateTime
import '../main.dart';

/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-28 15:46:24
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-30 05:01:18
/// @FilePath: lib/models/challenge.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class Challenge {
  final String id;
  final String name;
  final String description;
  final List<String> categories;
  final String difficulty;
  final String task;
  final List<String> tips;
  final String imagePath;
  final double co2;
  final String ngo;

  Challenge(
      {required this.name,
      required this.description,
      required this.categories,
      required this.difficulty,
      required this.task,
      this.tips = const [],
      required this.co2,
      required this.id,
      required this.ngo,
      this.imagePath = ""});

  int getCoins() {
    switch (this.difficulty.toLowerCase()) {
      case "easy":
        return 5;
      case "medium":
        return 10;
      case "hard":
        return 15;
      default:
        return 0;
    }
  }

  int getXp() {
    switch (this.difficulty.toLowerCase()) {
      case "easy":
        return 12;
      case "medium":
        return 18;
      case "hard":
        return 30;
      default:
        return 0;
    }
  }

  int getXpDev() {
    switch (this.difficulty.toLowerCase()) {
      case "easy":
        return 8;
      case "medium":
        return 14;
      case "hard":
        return 26;
      default:
        return 0;
    }
  }

  int getHealth() {
    switch (this.difficulty.toLowerCase()) {
      case "easy":
        return 5;
      case "medium":
        return 10;
      case "hard":
        return 20;
      default:
        return 0;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'description': this.description,
      'categories': this.categories,
      'difficulty': this.difficulty,
      'task': this.task,
      'tips': this.tips,
      'imagePath': this.imagePath,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      name: map['name'].toString(),
      description: map['description'].toString(),
      categories: List<String>.from(map["categories"]),
      difficulty: map['difficulty'].toString(),
      task: map['task'].toString(),
      tips: List<String>.from(map["tips"]),
      imagePath: map['imagePath'].toString(),
      co2: double.parse('${map['co2']}'),
      id: map['id'].toString(),
      ngo: map['ngo'].toString(),
    );
  }

  Future<void> scheduleRepeatingNotification(int hour, int minute) async {
    tz.initializeTimeZones();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'repeating_channel_id', // Channel ID
      'Repeating Notifications', // Channel name
      channelDescription: 'This channel is for repeating notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule a repeating notification every day at 8:00 AM
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Challenge Reminder', // Notification title
      name + " " + difficulty, // Notification body
      _nextInstanceOfTime(hour, minute), // Set time (8:00 AM)
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
    );
  }

// Helper function to get the next instance of a specific time
  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}
