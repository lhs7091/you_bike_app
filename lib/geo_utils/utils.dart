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
}
