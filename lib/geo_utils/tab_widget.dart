import 'package:flutter/material.dart';
import 'package:you_bike_app/geo_utils/utils.dart';
import 'package:you_bike_app/model/you_bike.dart';

class TabWidget extends StatelessWidget {
  // final ScrollController scrollController;
  YouBike? youBike;
  int subStrLeng = 'YouBike2.0_'.length;

  TabWidget({Key? key, this.youBike}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 초록, 주황, 빨강
          // 역명
          Container(
            height: 20,
            color: CommonUtil.getColor(youBike!),
          ),
          Text(
            "場站中文名稱",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            '   ${youBike!.sna.substring(subStrLeng)}',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            '   ${youBike!.snaen.substring(subStrLeng)}',
            style: TextStyle(color: Colors.white, fontSize: 18),
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
