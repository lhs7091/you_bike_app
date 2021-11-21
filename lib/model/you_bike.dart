import 'package:flutter_map/flutter_map.dart';

class YouBike {
  final String sno; // 사이트 코드
  final String sna; // 역이름
  final int tot; // 총 주차공간
  final int sbi; // 창고에 있는 현재 차량수
  final String sarea; // 역지역
  final String mday; // 데이터 업데이트 시간
  final double lat; // 위도
  final double lng; // 경도
  final String ar; // 위치
  final String sareaen; // 영어지역
  final String snaen; //영어 역이름
  final String aren; // 영어주소
  final String act; // 활성 비활성코드
  final String srcUpdateTime; // 소스 업데이트 시간
  Marker? marker;

  YouBike(
      {required this.sno,
      required this.sna,
      required this.tot,
      required this.sbi,
      required this.sarea,
      required this.mday,
      required this.lat,
      required this.lng,
      required this.ar,
      required this.sareaen,
      required this.snaen,
      required this.aren,
      required this.act,
      required this.srcUpdateTime});

  static YouBike fromJson(Map<dynamic, dynamic> json) => YouBike(
      sno: json['sno'],
      sna: json['sna'],
      tot: json['tot'],
      sbi: json['sbi'],
      sarea: json['sarea'],
      mday: json['mday'],
      lat: json['lat'],
      lng: json['lng'],
      ar: json['ar'],
      sareaen: json['sareaen'],
      snaen: json['snaen'],
      aren: json['aren'],
      act: json['act'],
      srcUpdateTime: json['srcUpdateTime']);
}
