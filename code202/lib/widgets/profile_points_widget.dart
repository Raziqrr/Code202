/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-28 13:03:14
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 18:41:59
/// @FilePath: lib/widgets/profile_points_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/models/stats.dart';
import 'package:code202/widgets/market_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/player.dart';

class ProfilePointsWidget extends StatelessWidget {
  const ProfilePointsWidget(
      {super.key,
      required this.player,
      required this.updateImage,
      required this.buyAvatar,
      required this.equipAvatar});
  final Player player;
  final void Function(String) updateImage;
  final void Function(String, String, int, BuildContext) buyAvatar;
  final void Function(String) equipAvatar;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellow,
            border: Border.all(color: Colors.yellow.shade600, width: 2)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Material(
              color: Colors.green.shade100,
              elevation: 4,
              shadowColor: Colors.yellow.shade600,
              borderRadius: BorderRadius.circular(6),
              child: InkWell(
                splashColor: Colors.green.shade900,
                borderRadius: BorderRadius.circular(6),
                onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheet(
                          backgroundColor: Colors.green.shade300,
                          onClosing: () {},
                          builder: (BuildContext context) {
                            return MarketWidget(
                              unlocked: player.unlockedProfiles,
                              updateImage: (path) {
                                updateImage(path);
                              },
                              buyAvatar: (name, path, price, context) {
                                buyAvatar(name, path, price, context);
                              },
                              equipAvatar: (path) {
                                equipAvatar(path);
                              },
                            );
                          },
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.green.shade700),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.shopping_cart_sharp,
                    color: Colors.green.shade900,
                    size: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${player.coins}",
                  style: GoogleFonts.micro5(
                      fontSize: 34,
                      shadows: [
                        Shadow(color: Colors.yellow.shade900, blurRadius: 6)
                      ],
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  CupertinoIcons.money_dollar_circle_fill,
                  color: Colors.white,
                  size: 26,
                  shadows: [
                    Shadow(color: Colors.yellow.shade900, blurRadius: 6)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
