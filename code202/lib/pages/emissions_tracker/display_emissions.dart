/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-31 14:44:58
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 15:09:55
/// @FilePath: lib/pages/emissions_tracker/display_emissions.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'emissions_tracker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carbon Saved Indicator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CarbonSavedPage(),
    );
  }
}

class CarbonSavedPage extends StatefulWidget {
  const CarbonSavedPage({super.key});

  @override
  _CarbonSavedPageState createState() => _CarbonSavedPageState();
}

class _CarbonSavedPageState extends State<CarbonSavedPage> {
  List<String> recentActivities = [];

  // Sample data for carbon savings for different vehicles
  Map<String, double> carbonSavings = {
    'Car': 0.0,
    'Bus': 0.0,
    'Flight': 0.0,
    'Train': 0.0,
    'Motorcycle': 0.0,
    'House': 0.0, // Include House
  };

  void addActivity(String activity, String details, double amount) {
    setState(() {
      recentActivities.insert(0, activity);

      // Parse the activity to extract carbon savings
      List<String> parts = activity.split(', ');
      String activityType = parts[0].split(': ')[1];
      double savings =
          double.tryParse(parts[1].split(': ')[1].split(' ')[0]) ?? 0.0;

      // Update carbon savings
      if (carbonSavings.containsKey(activityType)) {
        carbonSavings[activityType] =
            (carbonSavings[activityType] ?? 0.0) + savings;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Saved Indicator'),
        backgroundColor: Colors.green.shade700,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Pie chart for carbon savings
          Expanded(
            child: PieChart(
              PieChartData(
                sections: carbonSavings.entries.map((entry) {
                  return PieChartSectionData(
                    color: entry.key == 'Car'
                        ? Colors.red
                        : entry.key == 'Bus'
                            ? Colors.blue
                            : entry.key == 'Flight'
                                ? Colors.yellow
                                : entry.key == 'Train'
                                    ? Colors.orange
                                    : entry.key == 'Motorcycle'
                                        ? Colors.green
                                        : Colors.purple, // Color for House
                    value: entry.value,
                    title: entry.key,
                    radius: 60,
                  );
                }).toList(),
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),
          // List of recent activities
          Expanded(
            child: Container(
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: recentActivities.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(recentActivities[index]),
                    );
                  },
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddActivityPage(
                    onActivityAdded: addActivity,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C853),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text(
              'Add New Activity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
