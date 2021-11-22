import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:you_bike_app/api/you_bike_api.dart';
import 'package:you_bike_app/geo_utils/custom_react_tween.dart';
import 'package:you_bike_app/geo_utils/utils.dart';
import 'package:you_bike_app/model/you_bike.dart';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
class TabWidget extends StatefulWidget {
  final YouBike youBike;

  TabWidget({Key? key, required this.youBike}) : super(key: key);

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  YouBikeApi youBikeApi = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: CommonUtil.stationTag,
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
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(
                          Icons.circle,
                          size: 30,
                          color: CommonUtil.getColor(widget.youBike),
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          child: Text(
                            '${widget.youBike.sna.substring(CommonUtil.subStrLeng)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 역명
                          SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: Text(
                              '${widget.youBike.snaen.substring(CommonUtil.subStrLeng)}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status : ${widget.youBike.sbi} / ${widget.youBike.tot}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                '(車輛數量/總停車格)',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${widget.youBike.srcUpdateTime}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print("click favorite");
                                    setState(() {
                                      youBikeApi.updateFavoriteList(
                                          widget.youBike.sno);
                                    });
                                  },
                                  icon: Icon(
                                    youBikeApi.favoriteList
                                            .contains(widget.youBike.sno)
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text:
                                            "${widget.youBike.sna.substring(CommonUtil.subStrLeng)}"));
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  hoverColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
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
