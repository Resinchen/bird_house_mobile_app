import 'dart:async';

import 'package:birdhouseapp/domains/birdHouse.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'PieChart.dart';

class MapBirdHouse extends StatefulWidget {
  @override
  _MapBirdHouseState createState() => _MapBirdHouseState();
}

final scaffoldState = GlobalKey<ScaffoldState>();

class _MapBirdHouseState extends State<MapBirdHouse> {
  Completer<GoogleMapController> _controller = Completer();
  Map data = {};
  Set<Marker> _markers;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void convertToMarker(List<BirdHouse> birdHousesList) {
    _markers = birdHousesList
        .map((birdhouse) => Marker(
            markerId: MarkerId(birdhouse.idDevice),
            position: LatLng(
                birdhouse.location.latitude, birdhouse.location.longitude),
            infoWindow: InfoWindow(
                title: birdhouse.address.longHouse,
                snippet: birdhouse.address.city,
                onTap: () {
                  scaffoldState.currentState.showBottomSheet((context) =>
                      Container(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 4.0),
                              child: Column(children: <Widget>[
                                Card(
                                  child: ListTile(
                                    title:
                                        Text(birdhouse.address.longHouse ?? ''),
                                    subtitle:
                                        Text(birdhouse.address.longCity ?? ''),
                                    leading: birdhouse.getFilled(),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Посетители кормушки',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                ),
                                birdhouse.visiters.values
                                        .every((value) => value == 0)
                                    ? Text('Кормушку никто не посещал',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6)
                                    : PieChartWidget(birdhouse: birdhouse)
                              ]))));
                })))
        .toSet();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    convertToMarker(data['birdHousesList']);

    return Scaffold(
        key: scaffoldState,
        appBar: AppBar(
            title: Text('Карта устройств'), backgroundColor: Colors.blue[900]),
        body: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng(data['lat'], data['lon']), zoom: 15.0)));
  }
}
