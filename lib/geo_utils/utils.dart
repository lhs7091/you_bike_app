import 'package:flutter/material.dart';
import 'package:you_bike_app/model/you_bike.dart';

class CommonUtil {
  static Color getColor(YouBike youBike) {
    return youBike.sbi / youBike.tot >= 0.5
        ? Colors.green
        : youBike.sbi / youBike.tot >= 0.3
            ? Colors.orangeAccent
            : Colors.redAccent;
  }

  /// Dark background color.
  static const Color backgroundColor = Color(0xFF191D1F);

  /// Slightly lighter version of [backgroundColor].
  static const Color backgroundFadedColor = Color(0xFF191B1C);

  /// Color used for cards and surfaces.
  static const Color cardColor = Color(0xFF1F2426);

  /// Accent color used in the application.
  static const Color accentColor = Color(0xFFef8354);

  /// Favorite hero tag
  static const Text favoriteTag = Text("favorite");

  /// Station info hero tag
  static const Text stationTag = Text("station");

  /// subString
  static const int subStrLeng = 'YouBike2.0_'.length;
}
