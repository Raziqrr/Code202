/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-31 14:34:19
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 20:11:34
/// @FilePath: lib/widgets/market_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/fonts/custom_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/player.dart';

class MarketWidget extends StatefulWidget {
  const MarketWidget(
      {super.key,
      required this.unlocked,
      required this.updateImage,
      required this.buyAvatar,
      required this.equipAvatar});
  final List<String> unlocked;
  final void Function(String) updateImage;
  final void Function(String, String, int, BuildContext) buyAvatar;
  final void Function(String) equipAvatar;

  @override
  State<MarketWidget> createState() => _MarketWidgetState();
}

class _MarketWidgetState extends State<MarketWidget> {
  List<Map<String, dynamic>> profilePhotos = [
    {
      "name": "Little Leaf",
      "description": "A friendly character representing nature.",
      "imagePath": "assets/images/leaf_character.jpg",
      "price": 0
    },
    {
      "name": "Cool Panda",
      "description":
          "This charming panda embodies the spirit of wildlife conservation and the mission of WWF.",
      "imagePath": "assets/images/cool_panda.jpg",
      "price": 300
    },
    {
      "name": "Angel Panda",
      "description":
          "A cute panda that symbolizes peace and kindness, inspired by the values of WWF.",
      "imagePath": "assets/images/angel_panda.jpg",
      "price": 200
    },
    {
      "name": "Surprised Panda",
      "description":
          "A playful panda that brings joy, reflecting the joyful essence of wildlife protection according to WWF.",
      "imagePath": "assets/images/suprised_panda.jpg",
      "price": 200
    },
    {
      "name": "Cute Panda",
      "description":
          "An adorable panda that captures the heart, echoing the mission of conservation of WWF.",
      "imagePath": "assets/images/cute_panda.jpg",
      "price": 200
    },
    {
      "name": "Patrimonito",
      "description":
          "A character that celebrates cultural heritage and preservation, inspired by UNESCO's values.",
      "imagePath": "assets/images/patrimonito.jpg",
      "price": 400
    },
  ];

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.yellow.shade600),
              child: Icon(
                Icons.shopping_cart_sharp,
                color: Colors.white,
                size: 30,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Market",
              style: GoogleFonts.poppins(
                  color: Colors.yellow.shade600,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            SizedBox(
              height: 40,
            ),
            // Set a fixed height for the GridView
            SizedBox(
              height: 300,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisCount: 3,
                ),
                children: List.generate(profilePhotos.length, (index) {
                  profilePhotos
                      .sort((a, b) => a["price"].compareTo(b["price"]));

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      profilePhotos[index]["imagePath"]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(8)),
                          width: 100,
                          height: 100,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            profilePhotos[index]["name"],
                                            style: CustomFonts().primary_text,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            profilePhotos[index]["description"],
                                            style: CustomFonts().paragraph_text,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        onLongPress: () {
                          widget.buyAvatar(
                              profilePhotos[index]["name"],
                              profilePhotos[index]["imagePath"],
                              profilePhotos[index]["price"],
                              context);
                          widget.updateImage(profilePhotos[index]["imagePath"]);
                          widget.equipAvatar(profilePhotos[index]["imagePath"]);
                          print("changing");
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      !widget.unlocked.contains(profilePhotos[index]["name"])
                          ? Material(
                              child: InkWell(
                                onTap: () {
                                  widget.buyAvatar(
                                      profilePhotos[index]["name"],
                                      profilePhotos[index]["imagePath"],
                                      profilePhotos[index]["price"],
                                      context);
                                },
                                borderRadius: BorderRadius.circular(6),
                                splashColor: Colors.yellow.shade600,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.money_dollar_circle_fill,
                                        color: Color.fromARGB(255, 155, 128, 0),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${profilePhotos[index]["price"]}",
                                        style: GoogleFonts.micro5(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 155, 128, 0)),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6)),
                                  width: 100,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                ),
                              ),
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(6),
                            )
                          : SizedBox()
                    ],
                  );
                }),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }
}
