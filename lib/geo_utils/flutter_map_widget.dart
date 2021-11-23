import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:you_bike_app/api/ad_mob_api.dart';
import 'package:you_bike_app/api/you_bike_api.dart';
import 'package:you_bike_app/geo_utils/hero_dialog_router.dart';
import 'package:you_bike_app/geo_utils/tab_widget.dart';
import 'package:you_bike_app/geo_utils/utils.dart';
import 'package:you_bike_app/model/you_bike.dart';
import 'package:you_bike_app/secret/api_key.dart';

class FlutterMapWidget extends StatefulWidget {
  final MapController mapController;
  const FlutterMapWidget({required this.mapController, Key? key})
      : super(key: key);

  @override
  _FlutterMapWidgetState createState() => _FlutterMapWidgetState();

  static void moveMyLocation() {}
}

class _FlutterMapWidgetState extends State<FlutterMapWidget> {
  YouBikeApi youBikeApi = Get.find();
  late MapController _mapController;
  Position? position;

  List<YouBike> youBikeList = [];
  List<Marker> markers = [];

  bool _isLoading = true;

  YouBike? selectedYouBike;

  @override
  void initState() {
    super.initState();
    _mapController = widget.mapController;
    _getMyCurrentLocation();
    youBikeList = youBikeApi.youBikeList;
    new Timer.periodic(
        Duration(seconds: 5), (Timer t) => _getMyCurrentLocation());
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoading) {
      markers = setMarkerList(context);
    }

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: position == null
                        ? LatLng(25.033964, 121.564468)
                        : LatLng(position!.latitude, position!.longitude),
                    zoom: 15.0,
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate: urlTemplate,
                        additionalOptions: {
                          'accessToken': accessToken,
                          'id': 'mapbox.mapbox-streets-v8',
                        }),
                    MarkerLayerOptions(
                      markers: markers,
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                child: AdMobApi(),
              ),
            ],
          );
  }

  List<Marker> setMarkerList(BuildContext context) {
    youBikeList.forEach((element) {
      element.marker = createMarker(element);
    });
    List<Marker> _list = youBikeList.map((e) => e.marker!).toList();
    _list.insert(0, createMarker(null, isMe: true));
    return _list;
  }

  Marker createMarker(YouBike? _youBike, {bool isMe = false}) {
    return isMe
        ? Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(position!.latitude, position!.longitude),
            builder: (ctx) => Container(
              child: Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 30,
              ),
            ),
          )
        : Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(_youBike!.lat, _youBike.lng),
            builder: (ctx) => Container(
              child: IconButton(
                onPressed: () {
                  youBikeApi.setSelectedYouBike(_youBike.sno);
                  setState(() {
                    selectedYouBike = _youBike;
                  });
                  Navigator.of(context)
                      .push(HeroDialogRoute(builder: (context) {
                    return TabWidget(
                        youBike: youBikeApi.getOneYouBike(
                            youBikeApi.selectedYouBikeSno.value));
                  }));
                },
                icon: Icon(
                  Icons.location_on,
                ),
                color: CommonUtil.getColor(_youBike),
                iconSize:
                    // ignore: unrelated_type_equality_checks
                    youBikeApi.selectedYouBikeSno == _youBike.sno ? 50 : 20,
              ),
            ),
          );
  }

  void _getMyCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position p) => {
              setState(() {
                position = p;
                _isLoading = false;
              })
            });
  }

  void moveMyLocation() {
    setState(() {
      _mapController.move(
          LatLng(position!.latitude, position!.longitude), 15.0);
    });
  }
}
