import 'package:shared_preferences/shared_preferences.dart';

/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-28 23:51:21
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-31 15:12:28
/// @FilePath: lib/models/emissions.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class Emissions {
  double home;
  double transport;
  double food;
  double stuff;

  Emissions({
    required this.home,
    required this.transport,
    required this.food,
    required this.stuff,
  });

  Map<String, dynamic> toMap() {
    return {
      'home': this.home,
      'transport': this.transport,
      'food': this.food,
      'stuff': this.stuff,
    };
  }

  factory Emissions.fromMap(Map<String, dynamic> map) {
    return Emissions(
      home: double.parse(map["home"]),
      transport: double.parse(map["transport"]),
      food: double.parse(map["food"]),
      stuff: double.parse(map["stuff"]),
    );
  }

  factory Emissions.fromSharedPreferences(SharedPreferences prefs) {
    return Emissions(
      home: double.parse(prefs.getString("home") ?? "0.0"),
      transport: double.parse(prefs.getString("transport") ?? "0.0"),
      food: double.parse(prefs.getString("food") ?? "0.0"),
      stuff: double.parse(prefs.getString("stuff") ?? "0.0"),
    );
  }

  void addEmissions(String emissionType, double emissionAmount) {
    switch (emissionType.toLowerCase()) {
      case "home":
        this.home += emissionAmount;
        saveToSharedPreferences("home", this.home);
        break;
      case "transport":
        this.transport += emissionAmount;
        saveToSharedPreferences("transport", this.transport);
        break;
      case "food":
        this.food += emissionAmount;
        saveToSharedPreferences("food", this.food);
        break;
      case "stuff":
        this.stuff += emissionAmount;
        saveToSharedPreferences("stuff", this.stuff);
        break;
    }
  }

  void saveToSharedPreferences(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, "${value}");
  }
}
