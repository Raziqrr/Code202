/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-22 14:03:35
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 16:03:53
/// @FilePath: lib/widgets/minimized_emissions_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/colors/custom_colors.dart';
import 'package:code202/fonts/custom_fonts.dart';
import 'package:code202/models/emissions.dart';
import 'package:code202/pages/emissions_page.dart';
import 'package:code202/pages/emissions_tracker/emissions_tracker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/player.dart';

class MinimizedEmissionsWidget extends StatefulWidget {
  MinimizedEmissionsWidget(
      {super.key, required this.emissions, required this.dealDamage});
  final Emissions emissions;
  final int Function(double carbon) dealDamage;

  @override
  State<MinimizedEmissionsWidget> createState() =>
      _MinimizedEmissionsWidgetState();
}

class _MinimizedEmissionsWidgetState extends State<MinimizedEmissionsWidget> {
  Emissions emissions = Emissions(home: 0, transport: 0, food: 0, stuff: 0);

  void getEmissions() async {
    final prefs = await SharedPreferences.getInstance();
    emissions = Emissions.fromSharedPreferences(prefs);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    getEmissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Emissions",
              style: CustomFonts().primary_text,
            ),
            IconButton(
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return AddActivityPage(
                      onActivityAdded: (details, category, amount) {
                        print(details);
                        widget.emissions.addEmissions(category, amount);

                        // Calculate damage after adding emissions
                        final damageDone = widget.dealDamage(amount);

                        // Close the AddActivityPage and return to the previous screen
                        Navigator.pop(context);

                        // Use the original context for showing the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                              title: Center(child: Text("Damage Done")),
                              children: [
                                Column(
                                  children: [
                                    Text(
                                        "${amount.toStringAsFixed(2)} kg of CO₂"),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("- $damageDone"),
                                        Icon(
                                          CupertinoIcons.heart_fill,
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  }));

                  // Fetch emissions after the dialog is shown
                  getEmissions();
                },
                icon: Icon(
                  CupertinoIcons.arrow_right_circle_fill,
                  color: Colors.green.shade700,
                  size: 30,
                ))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Emissions This Month in CO₂ (kg)",
          style: CustomFonts().statsFontCustomColor(Colors.green.shade700, 18),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 250,
            child: BarChart(BarChartData(
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (title, _) {
                      List<String> titles = [
                        "",
                        "Home",
                        "Transport",
                        "Food",
                        "Stuff",
                        "Default"
                      ];
                      return Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          titles[title.toInt()],
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: CustomColors().primary_text,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    maxIncluded: false,
                    reservedSize: 40,
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      return Text(
                        value.toStringAsFixed(2),
                        style: TextStyle(
                          color: CustomColors().primary_text,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              barGroups: [
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(
                      toY: double.parse(
                          '${widget.emissions.home.toStringAsFixed(2)}'),
                      width: 30,
                      color: Colors.grey,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(3)))
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(
                      toY: double.parse(
                          '${widget.emissions.transport.toStringAsFixed(2)}'),
                      width: 30,
                      color: Colors.red.shade700,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(3)))
                ]),
                BarChartGroupData(x: 3, barRods: [
                  BarChartRodData(
                      toY: double.parse(
                          '${widget.emissions.food.toStringAsFixed(2)}'),
                      width: 30,
                      color: Colors.orange.shade700,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(3)))
                ]),
                BarChartGroupData(x: 4, barRods: [
                  BarChartRodData(
                      toY: double.parse(
                          '${widget.emissions.stuff.toStringAsFixed(2)}'),
                      width: 30,
                      color: Colors.purple.shade700,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(3)))
                ]),
              ],
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(color: Colors.blue, width: 3), // Left border
                  bottom:
                      BorderSide(color: Colors.blue, width: 3), // Bottom border
                  right: BorderSide.none, // No right border
                  top: BorderSide.none, // No top border
                ),
              ),
              gridData: FlGridData(show: false), // Disable grid lines
            )))
      ],
    );
  }
}
