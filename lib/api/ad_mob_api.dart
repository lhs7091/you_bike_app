import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobApi extends StatefulWidget {
  const AdMobApi({Key? key}) : super(key: key);

  @override
  _AdMobApiState createState() => _AdMobApiState();
}

class _AdMobApiState extends State<AdMobApi> {
  BannerAd? bannerAd;

  @override
  void initState() {
    super.initState();
    bannerAd = BannerAd(
        listener: BannerAdListener(),
        size: AdSize.banner,
        adUnitId: BannerAd.testAdUnitId,
        request: AdRequest())
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: this.bannerAd == null ? Container() : AdWidget(ad: this.bannerAd!),
    );
  }
}
