/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-26 11:26:16
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-26 17:15:11
/// @FilePath: lib/widgets/stats_guide_widget.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

import 'package:code202/colors/custom_colors.dart';
import 'package:flutter/material.dart';

import '../fonts/custom_fonts.dart';

class StatsGuideWidget extends StatelessWidget {
  const StatsGuideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Stats Guide",
              style: CustomFonts().primary_text,
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              "Intelligence",
              style: CustomFonts()
                  .statsFontCustomColor(CustomColors().intelligence_blue, 16),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Int",
              style: CustomFonts().statsFontCustomColor(
                  CustomColors().intelligence_blue.withOpacity(0.4), 16),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Expand your knowledge on climate change.\nIntelligence represents your understanding of climate change science. The more you know, the better you can make informed decisions to protect the environment.",
          style: CustomFonts().paragraph_text,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Awareness",
              style: CustomFonts()
                  .statsFontCustomColor(CustomColors().awareness_green, 16),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Awr",
              style: CustomFonts().statsFontCustomColor(
                  CustomColors().awareness_green.withOpacity(0.4), 16),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Be aware of the causes of climate change.\nAwareness helps you identify the factors driving climate change. By recognizing these causes, you can take steps to reduce your own environmental impact.",
          style: CustomFonts().paragraph_text,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Strength",
              style: CustomFonts()
                  .statsFontCustomColor(CustomColors().strength_red, 16),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Str",
              style: CustomFonts().statsFontCustomColor(
                  CustomColors().strength_red.withOpacity(0.4), 16),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Discover ways to combat climate change.\nStrength gives you the power to make a difference. Learn practical solutions and actions to help in the fight against climate change.",
          style: CustomFonts().paragraph_text,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Resilience",
              style: CustomFonts()
                  .statsFontCustomColor(CustomColors().resilience_orange, 16),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Res",
              style: CustomFonts().statsFontCustomColor(
                  CustomColors().resilience_orange.withOpacity(0.4), 16),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Understand the impact and effects of climate change.\nResilience prepares you to face the consequences of climate change. By knowing the effects, you can help create plans for recovery and adaptation.",
          style: CustomFonts().paragraph_text,
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Devotion",
              style: CustomFonts()
                  .statsFontCustomColor(CustomColors().devotion_pink, 16),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Dev",
              style: CustomFonts().statsFontCustomColor(
                  CustomColors().devotion_pink.withOpacity(0.4), 16),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Gain levels by completing tasks and challenges.\nDevotion shows your commitment to the cause. Earn this stat by taking real action to protect the planet and inspire others to do the same.",
          style: CustomFonts().paragraph_text,
        ),
      ],
    );
  }
}
