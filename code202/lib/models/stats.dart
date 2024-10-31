import 'package:shared_preferences/shared_preferences.dart';

/// @Author: Raziqrr rzqrdzn03@gmail.com
/// @Date: 2024-10-28 16:13:02
/// @LastEditors: Raziqrr rzqrdzn03@gmail.com
/// @LastEditTime: 2024-10-28 17:13:14
/// @FilePath: lib/models/stats.dart
/// @Description: 这是默认设置,可以在设置》工具》File Description中进行配置

class Stats {
  int intLevel;
  int intXp;
  int awrLevel;
  int awrXp;
  int strLevel;
  int strXp;
  int resLevel;
  int resXp;
  int devLevel;
  int devXp;

  Stats(
      {required this.intLevel,
      required this.intXp,
      required this.awrLevel,
      required this.awrXp,
      required this.strLevel,
      required this.strXp,
      required this.resLevel,
      required this.resXp,
      required this.devLevel,
      required this.devXp});

  factory Stats.fromSharedPreferences(SharedPreferences prefs) {
    // Define default values
    const int defaultIntLevel = 1;
    const int defaultIntXp = 0;
    const int defaultAwrLevel = 1;
    const int defaultAwrXp = 0;
    const int defaultStrLevel = 1;
    const int defaultStrXp = 0;
    const int defaultResLevel = 1;
    const int defaultResXp = 0;
    const int defaultDevLevel = 1;
    const int defaultDevXp = 0;

    // Load values from SharedPreferences, or use defaults and save them if not present
    int intLevel = prefs.getInt('intLevel') ?? defaultIntLevel;
    if (prefs.getInt('intLevel') == null) {
      prefs.setInt('intLevel', defaultIntLevel);
    }

    int intXp = prefs.getInt('intXp') ?? defaultIntXp;
    if (prefs.getInt('intXp') == null) {
      prefs.setInt('intXp', defaultIntXp);
    }

    int awrLevel = prefs.getInt('awrLevel') ?? defaultAwrLevel;
    if (prefs.getInt('awrLevel') == null) {
      prefs.setInt('awrLevel', defaultAwrLevel);
    }

    int awrXp = prefs.getInt('awrXp') ?? defaultAwrXp;
    if (prefs.getInt('awrXp') == null) {
      prefs.setInt('awrXp', defaultAwrXp);
    }

    int strLevel = prefs.getInt('strLevel') ?? defaultStrLevel;
    if (prefs.getInt('strLevel') == null) {
      prefs.setInt('strLevel', defaultStrLevel);
    }

    int strXp = prefs.getInt('strXp') ?? defaultStrXp;
    if (prefs.getInt('strXp') == null) {
      prefs.setInt('strXp', defaultStrXp);
    }

    int resLevel = prefs.getInt('resLevel') ?? defaultResLevel;
    if (prefs.getInt('resLevel') == null) {
      prefs.setInt('resLevel', defaultResLevel);
    }

    int resXp = prefs.getInt('resXp') ?? defaultResXp;
    if (prefs.getInt('resXp') == null) {
      prefs.setInt('resXp', defaultResXp);
    }

    int devLevel = prefs.getInt('devLevel') ?? defaultDevLevel;
    if (prefs.getInt('devLevel') == null) {
      prefs.setInt('devLevel', defaultDevLevel);
    }

    int devXp = prefs.getInt('devXp') ?? defaultDevXp;
    if (prefs.getInt('devXp') == null) {
      prefs.setInt('devXp', defaultDevXp);
    }

    return Stats(
      intLevel: intLevel,
      intXp: intXp,
      awrLevel: awrLevel,
      awrXp: awrXp,
      strLevel: strLevel,
      strXp: strXp,
      resLevel: resLevel,
      resXp: resXp,
      devLevel: devLevel,
      devXp: devXp,
    );
  }
}
