import 'package:birdhouseapp/domains/birdHouse.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class BirdHouseTile extends StatefulWidget {
  final BirdHouse birdhouse;

  const BirdHouseTile({Key key, this.birdhouse}) : super(key: key);

  @override
  _BirdHouseTileState createState() => _BirdHouseTileState();
}

class _BirdHouseTileState extends State<BirdHouseTile> {
  Geolocator _geolocator;
  BirdHouse birdHouse;
  String distance;

  @override
  void initState() {
    super.initState();
    _geolocator = Geolocator();

    setState(() {
      birdHouse = widget.birdhouse;
    });

    getDiffGeolocation(birdHouse).then((value) => setState(() {
          distance = '${value.toStringAsFixed(2)} \nmeters';
        }));
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<double> getDiffGeolocation(BirdHouse birdHouse) async {
    Position _position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    double distance = await _geolocator.distanceBetween(
        birdHouse.location.latitude,
        birdHouse.location.longitude,
        _position.latitude,
        _position.longitude);
    return distance;
  }

  @override
  Widget build(BuildContext context) {
    getDiffGeolocation(birdHouse).then((value) => setState(() {
          distance = '${value.toStringAsFixed(2)} \nmeters';
        }));

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
        child: Card(
            child: ListTile(
                title: Text(birdHouse.address.longHouse ?? ''),
                subtitle: Text(birdHouse.address.longCity ?? ''),
                leading: birdHouse.getFilled(),
                trailing: Text(distance ?? ''))));
  }
}
