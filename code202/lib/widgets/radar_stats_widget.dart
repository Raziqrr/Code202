/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-22 11:37:14
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-30 06:01:46
/// @FilePath: lib/widgets/radar_stats_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/colors/custom_colors.dart';
import 'package:code202/models/stats.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RadarStatsWidget extends StatelessWidget {
  RadarStatsWidget({super.key, required this.stats});
  final Stats stats;

  @override
  Widget build(BuildContext context) {
    return RadarChart(
      RadarChartData(
          radarBorderData: BorderSide(color: Colors.green),
          gridBorderData: BorderSide(color: Colors.green),
          radarBackgroundColor: Colors.green.withOpacity(0.2),
          tickCount: 4,
          tickBorderData: BorderSide(color: Colors.green, width: 0),
          radarShape: RadarShape.polygon,
          titleTextStyle: GoogleFonts.uncialAntiqua(
              fontSize: 18,
              color: CustomColors().primary_text.withOpacity(0.7)),
          getTitle: (value, index) {
            List<String> titles = ["Int", "Awr", "Str", "Res", "Dev", "6"];
            return RadarChartTitle(text: titles[value]);
          },
          ticksTextStyle: TextStyle(fontSize: 0),
          dataSets: [
            RadarDataSet(
                borderWidth: 0,
                entryRadius: 0,
                fillColor: Colors.blue.withOpacity(0.5),
                borderColor: Colors.green,
                dataEntries: [
                  RadarEntry(value: stats.intLevel.toDouble()),
                  RadarEntry(value: stats.awrLevel.toDouble()),
                  RadarEntry(value: stats.strLevel.toDouble()),
                  RadarEntry(value: stats.resLevel.toDouble()),
                  RadarEntry(value: stats.devLevel.toDouble())
                ])
          ]),
    );
  }
}
