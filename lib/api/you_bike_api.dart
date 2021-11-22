import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_bike_app/model/you_bike.dart';
import 'package:get/get.dart';

class YouBikeApi extends GetxController {
  final youBikeList = <YouBike>[].obs;
  final favoriteList = <String>[].obs;
  final selectedYouBikeSno = RxString("");

  onInit() {
    getYouBikeList();
    getFavoriteList();
  }

  Future<List<YouBike>> getYouBikeList() async {
    final url = Uri.parse(
        'https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List youBikes = json.decode(response.body);
      print(youBikes);

      this.youBikeList.value = youBikes
          .map((json) => YouBike.fromJson(json))
          .where((element) => element.act == "1")
          .toList();

      return youBikes.map((json) => YouBike.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }

  getFavoriteList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? _favoriteList = pref.getStringList("favorite");
    if (_favoriteList != null) {
      this.favoriteList.value = _favoriteList;
    }
  }

  updateFavoriteList(String sno) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (this.favoriteList.contains(sno)) {
      this.favoriteList.remove(sno);
    } else {
      this.favoriteList.add(sno);
    }
    pref.setStringList("favorite", this.favoriteList);
    update();
  }

  setSelectedYouBike(String selectedSno) {
    selectedYouBikeSno.value = selectedSno;
    update();
  }

  YouBike getOneYouBike(String sno) {
    return this.youBikeList.firstWhere((element) => element.sno == sno);
  }
}
