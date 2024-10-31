/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-24 16:28:37
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 20:28:01
/// @FilePath: lib/pages/challenge_detail_page.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:code202/colors/custom_colors.dart';
import 'package:code202/fonts/custom_fonts.dart';
import 'package:code202/models/challenge.dart';
import 'package:code202/models/player.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/friend.dart';

class ChallengeDetailPage extends StatefulWidget {
  const ChallengeDetailPage(
      {super.key,
      required this.difficulty,
      required this.categories,
      required this.player,
      required this.challenge,
      required this.isDaily});
  final String difficulty;
  final List<String> categories;
  final Player player;
  final Challenge challenge;
  final bool isDaily;

  @override
  State<ChallengeDetailPage> createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {
  Color getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "easy":
        return Colors.green;
      case "medium":
        return Colors.yellow.shade600;
      case "hard":
        return Colors.red.shade500;
      default:
        return Colors.pink;
    }
  }

  Color getDifficultyTextColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "easy":
        return Colors.green.shade100;
      case "medium":
        return Colors.yellow.shade100;
      case "hard":
        return Colors.red.shade100;
      default:
        return Colors.pink.shade100;
    }
  }

  Widget getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case "home":
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(3)),
          child: Row(
            children: [
              Icon(
                Icons.maps_home_work_sharp,
                color: Colors.grey,
                size: 18,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Home",
                style: GoogleFonts.poppins(
                    color: Colors.grey, fontWeight: FontWeight.w500),
              )
            ],
          ),
        );
      case "transport":
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(3)),
            child: Row(
              children: [
                Icon(Icons.directions_car,
                    size: 18, color: Colors.red.shade100),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Transport",
                  style: GoogleFonts.poppins(
                      color: Colors.red.shade100, fontWeight: FontWeight.w500),
                )
              ],
            ));
      case "food":
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.orange.shade700,
                borderRadius: BorderRadius.circular(3)),
            child: Row(
              children: [
                Icon(Icons.restaurant, size: 18, color: Colors.orange.shade100),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Food",
                  style: GoogleFonts.poppins(
                      color: Colors.orange.shade100,
                      fontWeight: FontWeight.w500),
                )
              ],
            ));
      case "stuff":
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 2),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.purple.shade700,
                borderRadius: BorderRadius.circular(3)),
            child: Row(
              children: [
                Icon(Icons.checkroom_rounded,
                    size: 18, color: Colors.purple.shade100),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Stuff",
                  style: GoogleFonts.poppins(
                      color: Colors.purple.shade100,
                      fontWeight: FontWeight.w500),
                )
              ],
            ));
      default:
        return Icon(Icons.info, size: 14, color: Colors.blue);
    }
  }

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  String selectedFriend = "";
  TextEditingController friendUidController = TextEditingController();

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  bool gotConnection() {
    if (_connectionStatus.contains(ConnectivityResult.wifi) ||
        _connectionStatus.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }

  void checkId() {
    print("checking");
    Challenge(
            name: "",
            description: "",
            categories: [],
            difficulty: "",
            task: "",
            co2: 0,
            id: '',
            ngo: '')
        .scheduleRepeatingNotification(10, 30);
    if (widget.player.uid == "") {
      print("no uid");
      final db = FirebaseFirestore.instance;
      db.collection("ClimateUsers").add({
        "name": widget.player.username,
        "token": widget.player.token
      }).then((result) {
        print(result.id);
        setState(() {
          widget.player.setUid(result.id);
        });
      });
    } else {
      print("got uid");
      widget.player.token;
      print(widget.player.token);
      print(widget.player.uid);
    }
  }

  void openAddFriend(BuildContext context) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            "Enter Friend UID",
            style: CustomFonts().primary_text,
          )),
          content: TextField(
            controller: friendUidController,
            decoration: InputDecoration(hintText: "Friend UID"),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.player.addFriend(friendUidController.text);
                  });
                  Navigator.pop(context);
                },
                child: Text("Add"))
          ],
        );
      },
    );
  }

  void openFriendList(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return AlertDialog(
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            sendNotifications(
                                widget.player.friends.where((f) {
                                  return f.uid == selectedFriend;
                                }).first,
                                widget.challenge.name);
                            Navigator.pop(context);
                          },
                          child: Text("Invite")),
                    ),
                  ],
                )
              ],
              title: Center(
                  child: Text(
                "Invite friends to do this task",
                style: CustomFonts().primary_text,
              )),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("My Friends"),
                      IconButton(
                          onPressed: () {
                            openAddFriend(context);
                          },
                          icon: Icon(CupertinoIcons.person_badge_plus_fill))
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.player.friends.length < 1
                        ? List.generate(
                            widget.player.friends.length,
                            (index) => RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                value: widget.player.friends[index].uid,
                                title: Text(widget.player.friends[index].name),
                                groupValue: selectedFriend,
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedFriend = value;
                                    });
                                  }
                                }))
                        : [Text("No friends")],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> sendNotifications(Friend friend, String challenge) async {
    try {
      // Sample data payload with individual messages for each user
      final data = {
        "title": "Coop challenge invitation by ${widget.player.username}",
        "users": [
          {
            "uid": friend.uid,
            "token": friend.token,
            "content":
                "Hi ${friend.name}! Join me to complete the task '${challenge}'"
          },
        ],
      };
      print(data);
      // Call the Firebase function
      await FirebaseFunctions.instance
          .httpsCallable('sendNotificationToMultipleUsers')
          .call(data);

      print("Notifications sent successfully!");
    } catch (e) {
      print("Error sending notifications: $e");
    }
  }

  void finishChallenge(BuildContext context) async {
    final currentHealth = widget.player.health;

    print("completed");
    if (!completed.contains(widget.challenge.id)) {
      if (widget.isDaily) {
        final prefs = await SharedPreferences.getInstance();
        completed.add(widget.challenge.id);
        prefs.setStringList("completedDailies", completed);
      } else {
        widget.player.completeChallenge(widget.challenge.id);
      }
      widget.player.addChallengeCompleteStats(
          widget.isDaily
              ? widget.challenge.getCoins()
              : widget.challenge.getCoins() * 2,
          widget.isDaily
              ? widget.challenge.getXpDev()
              : widget.challenge.getXpDev() * 2,
          widget.isDaily
              ? widget.challenge.getXp()
              : widget.challenge.getXp() * 2,
          widget.challenge.getHealth(),
          widget.challenge.co2);
    }
    setState(() {});
    print(completed);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Challenge Completed",
              style: CustomFonts().primary_text,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Gained ${widget.challenge.getCoins()} Coins"),
                SizedBox(
                  height: 5,
                ),
                Text("Gained ${widget.challenge.getXp()} Xp"),
                SizedBox(
                  height: 5,
                ),
                Text("Gained ${widget.challenge.getXpDev()} Dev Xp"),
                SizedBox(
                  height: 5,
                ),
                Text("Healed ${widget.player.health - currentHealth} health"),
                SizedBox(
                  height: 5,
                ),
                Text("Saved ${widget.challenge.co2} CO2"),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
        });
  }

  void resetChallenge(BuildContext context) async {
    print("reset");
    if (completed.contains(widget.challenge.id)) {
      if (widget.isDaily) {
        final prefs = await SharedPreferences.getInstance();
        completed.remove(widget.challenge.id);
        prefs.setStringList("completedDailies", completed);
      } else {
        completed.remove(widget.challenge.id);
        widget.player.resetChallenge(widget.challenge.id);
      }
    }
    setState(() {});
    print(completed);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Challenge has been reset"),
          );
        });
  }

  void getCompleted() async {
    if (widget.isDaily) {
      final prefs = await SharedPreferences.getInstance();
      completed = prefs.getStringList("completedDailies") ?? [];
    } else {
      completed = widget.player.completedChallenges;
    }
    setState(() {});
    print(completed);
    print("init complete");
  }

  @override
  void initState() {
    getCompleted();
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  List<String> completed = [];
  TimeOfDay? selectedTime; // To hold selected time
  DateTime? selectedDate; // To hold selected date
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: !widget.isDaily &&
                            completed.contains(widget.challenge.id)
                        ? () {
                            resetChallenge(context);
                          }
                        : widget.isDaily &&
                                completed.contains(widget.challenge.id)
                            ? null
                            : () {
                                finishChallenge(context);
                              },
                    child: Text(
                      !widget.isDaily && completed.contains(widget.challenge.id)
                          ? "Reset"
                          : widget.isDaily &&
                                  completed.contains(widget.challenge.id)
                              ? "Completed"
                              : "Finish",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                          color: Colors.white),
                    ))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.green.shade700, width: 2),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    shape: CircleBorder()),
                onPressed: gotConnection() == true
                    ? () {
                        openFriendList(context);
                        checkId();
                      }
                    : null,
                child: gotConnection() == false
                    ? Icon(CupertinoIcons.wifi_slash)
                    : Icon(
                        CupertinoIcons.person_3_fill,
                        color: Colors.green.shade700,
                        size: 24,
                      ))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.left_chevron,
              color: Colors.green.shade700,
              size: 30,
              weight: 30,
            )),
        actions: [
          Material(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              splashColor: Colors.green.shade100.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                //set reminder
                print("Setting");
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context,
                            void Function(void Function()) setState) {
                          return AlertDialog(
                            title: Text("Schedule Task"),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Time: "),
                                      SizedBox(width: 10),
                                      TextButton(
                                        onPressed: () async {
                                          TimeOfDay? time =
                                              await showTimePicker(
                                            context: context,
                                            initialTime:
                                                selectedTime ?? TimeOfDay.now(),
                                          );
                                          if (time != null) {
                                            selectedTime =
                                                time; // Set the selected time
                                          }
                                        },
                                        child: Text(selectedTime != null
                                            ? selectedTime!.format(context)
                                            : "Select Time"),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Date: "),
                                      SizedBox(width: 10),
                                      TextButton(
                                        onPressed: () async {
                                          DateTime? date = await showDatePicker(
                                            context: context,
                                            initialDate:
                                                selectedDate ?? DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2101),
                                          );
                                          if (date != null) {
                                            selectedDate =
                                                date; // Set the selected date
                                          }
                                        },
                                        child: Text(selectedDate != null
                                            ? DateFormat('yyyy-MM-dd')
                                                .format(selectedDate!)
                                            : "Select Date"),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (selectedTime != null &&
                                      selectedDate != null) {
                                    // Schedule the notification
                                    widget.challenge
                                        .scheduleRepeatingNotification(
                                      selectedTime!.hour,
                                      selectedTime!.minute,

                                      //set state
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Notification Scheduled")),
                                    );
                                    Navigator.of(context)
                                        .pop(); // Close the dialog after scheduling
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Please select both time and date")),
                                    );
                                  }
                                },
                                child: Text("Schedule"),
                              ),
                            ],
                          );
                        },
                      );
                    });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      size: 18,
                      color: Colors.green.shade700,
                    ),
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 20,
                      color: Colors.green.shade700,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
        title: Text(
          widget.challenge.name,
          style: CustomFonts().primary_text,
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
                        image:
                            AssetImage("assets${widget.challenge.imagePath}"))),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: getDifficultyColor(
                                widget.challenge.difficulty)),
                        child: Row(
                          children: [
                            Text(
                              widget.challenge.difficulty,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: getDifficultyTextColor(
                                      widget.challenge.difficulty)),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Row(
                              children: List.generate(
                                widget.challenge.difficulty.toLowerCase() ==
                                        "hard"
                                    ? 3
                                    : widget.challenge.difficulty
                                                .toLowerCase() ==
                                            "medium"
                                        ? 2
                                        : widget.challenge.difficulty
                                                    .toLowerCase() ==
                                                "easy"
                                            ? 1
                                            : 0, // Calculate the number of stars based on difficulty
                                (index) => Icon(
                                  Icons.star,
                                  color: getDifficultyTextColor(
                                      widget.challenge.difficulty),
                                  size: 14,
                                ), // Display stars
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                                widget.challenge.categories.length, (index) {
                              return getCategoryIcon(
                                  widget.challenge.categories[index]);
                            }),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.isDaily
                                ? "+ ${widget.challenge.getCoins() * 2}"
                                : "+ ${widget.challenge.getCoins()}",
                            style: GoogleFonts.poppins(
                                color: Colors.yellow.shade700,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            CupertinoIcons.money_dollar_circle_fill,
                            color: Colors.yellow.shade700,
                            size: 18,
                          )
                        ],
                      ),
                      Text(
                        widget.isDaily
                            ? "+ ${widget.challenge.getXpDev() * 2} Dev Xp"
                            : "+ ${widget.challenge.getXpDev()} Dev Xp",
                        style: GoogleFonts.poppins(
                            color: CustomColors().devotion_pink,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        widget.isDaily
                            ? "+ ${widget.challenge.getXp() * 2} Xp"
                            : "+ ${widget.challenge.getXp()} Xp",
                        style: GoogleFonts.poppins(
                            color: Colors.green.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "- ${widget.challenge.co2} CO2",
                        style: GoogleFonts.poppins(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Task",
                    style: CustomFonts().primary_text,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    widget.challenge.task,
                    style: CustomFonts().paragraph_text,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Description",
                    style: CustomFonts().primary_text,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                alignment: AlignmentDirectional.topStart,
                child: Text(
                    textAlign: TextAlign.start,
                    style: CustomFonts().paragraph_text,
                    widget.challenge.description),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Tips", style: CustomFonts().primary_text),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.challenge.tips.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    "${index + 1}. ${widget.challenge.tips[index]}",
                    style: CustomFonts().paragraph_text,
                  );
                },
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
