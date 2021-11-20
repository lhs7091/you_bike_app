import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:you_bike_app/model/you_bike.dart';

class YouBikeApi {
  static Future<List<YouBike>> getYouBikeList() async {
    final url = Uri.parse(
        'https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List youBikes = json.decode(response.body);
      print(youBikes);
      return youBikes.map((json) => YouBike.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}