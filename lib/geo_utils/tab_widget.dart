import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_bike_app/api/you_bike_api.dart';
import 'package:you_bike_app/geo_utils/utils.dart';
import 'package:you_bike_app/model/you_bike.dart';

class TabWidget extends StatelessWidget {
  YouBikeApi youBikeApi = Get.find();
  YouBike? youBike;
  int subStrLeng = 'YouBike2.0_'.length;

  TabWidget({Key? key, this.youBike}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 역명
          Container(
            height: 20,
            color: CommonUtil.getColor(youBike!),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "場站中文名稱",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    '   ${youBike!.sna.substring(subStrLeng)}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    youBike!.snaen.substring(subStrLeng).length > 30
                        ? '   ${youBike!.snaen.substring(subStrLeng).substring(0, 30)}'
                        : '   ${youBike!.snaen.substring(subStrLeng)}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  youBikeApi.updateFavoriteList(youBike!.sno);
                },
                icon: Icon(
                  youBikeApi.favoriteList.contains(youBike!.sno)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status : ${youBike!.sbi} / ${youBike!.tot}',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                '(場站目前車輛數量/場站總停車格)',
                style: TextStyle(color: Colors.white, fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text(
            "updateTime : ${youBike!.srcUpdateTime}",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
