import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:you_bike_app/api/you_bike_api.dart';
import 'package:you_bike_app/geo_utils/favorite_card_widget.dart';
import 'package:you_bike_app/geo_utils/flutter_map_widget.dart';
import 'package:you_bike_app/geo_utils/geo_determine_position.dart';
import 'package:latlong2/latlong.dart';
import 'package:you_bike_app/geo_utils/hero_dialog_router.dart';
import 'package:you_bike_app/geo_utils/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MapController _mapController = MapController();
  YouBikeApi youBikeApi = Get.put(YouBikeApi());

  @override
  void initState() {
    super.initState();
    GeoDeterminePosition.determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: FlutterMapWidget(mapController: _mapController),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Column(
        children: [
          buildFloatingActionBtn(context, refreshBtn, Icons.refresh, null),
          SizedBox(height: 10),
          buildFloatingActionBtn(
              context, getCurrentLocationBtn, Icons.location_searching, null),
          SizedBox(height: 10),
          buildFloatingActionBtn(
              context, favoriteBtn, Icons.favorite, CommonUtil.favoriteTag),
        ],
      ),
    );
  }

  Widget buildFloatingActionBtn(BuildContext context, VoidCallback function,
      IconData icons, Text? heroTag) {
    return FloatingActionButton(
      onPressed: function,
      child: Icon(icons),
      backgroundColor: Colors.black38,
      hoverColor: Colors.white,
      heroTag: heroTag,
    );
  }

  refreshBtn() {
    // List<YouBike> _youBikeList = await YouBikeApi.getYouBikeList();
    youBikeApi.getYouBikeList();
  }

  getCurrentLocationBtn() async {
    Position p = await GeoDeterminePosition.getMyCurrentLocation();
    _mapController.move(LatLng(p.latitude, p.longitude), 15.0);
    // _mapController.move(LatLng(25.033964, 121.564468), 15.0);
  }

  favoriteBtn() {
    Navigator.of(context).push(HeroDialogRoute(builder: (context) {
      return FavoriteCardWidet(mapController: _mapController);
    }));
  }
}
