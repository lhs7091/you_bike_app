import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:you_bike_app/api/you_bike_api.dart';
import 'package:you_bike_app/geo_utils/custom_react_tween.dart';
import 'package:you_bike_app/geo_utils/utils.dart';
import 'package:you_bike_app/model/you_bike.dart';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
class FavoriteCardWidet extends StatefulWidget {
  final mapController;
  FavoriteCardWidet({Key? key, this.mapController}) : super(key: key);

  @override
  State<FavoriteCardWidet> createState() => _FavoriteCardWidetState();
}

class _FavoriteCardWidetState extends State<FavoriteCardWidet> {
  YouBikeApi youBikeApi = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: CommonUtil.favoriteTag,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            color: CommonUtil.cardColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'favorite',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 30,
                      ),
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                        itemCount: youBikeApi.favoriteList.length,
                        itemBuilder: (context, index) {
                          var youBike = getFavoriteYouBike(
                              youBikeApi.favoriteList[index]);
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  youBikeApi.setSelectedYouBike(youBike.sno);
                                  widget.mapController.move(
                                      LatLng(youBike.lat, youBike.lng), 15.0);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "${youBike.sna.substring(CommonUtil.subStrLeng)}",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  YouBike getFavoriteYouBike(String sno) {
    YouBike youBike =
        youBikeApi.youBikeList.firstWhere((element) => element.sno == sno);
    return youBike;
  }
}
