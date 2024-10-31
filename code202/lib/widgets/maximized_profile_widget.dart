/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-20 23:22:30
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 17:02:59
/// @FilePath: lib/widgets/maximized_profile_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'dart:convert';

import 'package:code202/models/rank_and_level_system.dart';
import 'package:code202/widgets/rank_emblem_widget.dart';
import 'package:code202/widgets/round_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/custom_colors.dart';
import '../models/challenge.dart';
import '../models/player.dart';

class MaximizedProfileWidget extends StatefulWidget {
  const MaximizedProfileWidget({super.key, required this.player});
  final Player player;

  @override
  State<MaximizedProfileWidget> createState() => _MaximizedProfileWidgetState();
}

class _MaximizedProfileWidgetState extends State<MaximizedProfileWidget> {
  TextEditingController newUsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          RoundImageWidget(
            imagePath: widget.player.profileAvatar,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        child: Text(
                          widget.player.username, //username
                          style: GoogleFonts.uncialAntiqua(),
                        ),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                            children: [
                              SelectableText("UID : ${widget.player.uid}"),
                              IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                            text: widget.player.uid))
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("Copied to clipboard")));
                                    });
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    color: Colors.grey.shade100,
                                    size: 18,
                                  ))
                            ],
                          )));
                        },
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(100),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text("Enter new username"),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextField(
                                        controller: newUsernameController,
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel")),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            widget.player.setUsername(
                                                newUsernameController.text);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text("Confirm"))
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.edit,
                              size: 17,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  RankEmblemWidget(
                    player: widget.player,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Lvl. ${widget.player.level}",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.player.xp}/${Rank().getLevelCap(widget.player.level)}",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        minHeight: 14,
                        borderRadius: BorderRadius.circular(3),
                        color: CupertinoColors.systemYellow,
                        value: widget.player.xp != 0
                            ? double.parse(
                                '${widget.player.xp / Rank().getLevelCap(widget.player.level)}')
                            : 0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.heart_fill,
                            size: 16,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            "Health",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.player.health}/100",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey.withOpacity(0.3),
                        minHeight: 14,
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.red,
                        value: double.parse('${widget.player.health}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
