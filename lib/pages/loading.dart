import 'package:birdhouseapp/services/birdHouseService.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool loaded = false;
  Map data = {};
  Position _position;

  Geolocator _geolocator;

  void setupBirdhouse() async {
    BirdHouseService instance = BirdHouseService();
    await instance.getData();
    _position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    loaded = instance.birdHousesList.length != 0;
    Navigator.pushReplacementNamed(context, data['route'], arguments: {
      'birdHousesList': instance.birdHousesList,
      'lat': _position.latitude,
      'lon': _position.longitude
    });
  }

  @override
  void initState() {
    super.initState();
    _geolocator = Geolocator();
    setupBirdhouse();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(child: SpinKitWave(color: Colors.white, size: 80.0)));
  }
}
