import 'package:code202/colors/custom_colors.dart';
import 'package:code202/widgets/badges_display_widget.dart';
import 'package:code202/widgets/custom_navigation_bar.dart';
import 'package:code202/widgets/maximized_profile_widget.dart';
import 'package:code202/widgets/radar_stats_widget.dart';
import 'package:code202/widgets/stats_guide_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-26 12:05:05
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-27 11:39:13
/// @FilePath: lib/fonts/custom_fonts.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class CustomFonts {
  TextStyle intelligenceSmall = GoogleFonts.poppins(
      fontSize: 16,
      color: CustomColors().intelligence_blue,
      fontWeight: FontWeight.w600);
  TextStyle awarenessSmall = GoogleFonts.poppins(
      fontSize: 16,
      color: CustomColors().awareness_green,
      fontWeight: FontWeight.w600);
  TextStyle strengthSmall = GoogleFonts.poppins(
      fontSize: 16,
      color: CustomColors().strength_red,
      fontWeight: FontWeight.w600);
  TextStyle resilienceSmall = GoogleFonts.poppins(
      fontSize: 16,
      color: CustomColors().resilience_orange,
      fontWeight: FontWeight.w600);
  TextStyle devotionSmall = GoogleFonts.poppins(
      fontSize: 16,
      color: CustomColors().devotion_pink,
      fontWeight: FontWeight.w600);
  TextStyle primary_text = GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: CustomColors().primary_text);
  TextStyle paragraph_text = GoogleFonts.roboto(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  TextStyle challengesFontCustomColor(Color color) {
    return GoogleFonts.poppins(
        color: color, fontSize: 18, fontWeight: FontWeight.w700);
  }

  TextStyle challengesFontCustomColor2(Color color) {
    return GoogleFonts.poppins(
        color: color, fontSize: 16, fontWeight: FontWeight.w500);
  }

  TextStyle statsFontCustomColor(Color color, double size) {
    return GoogleFonts.poppins(
        color: color, fontSize: size, fontWeight: FontWeight.w500);
  }
}
