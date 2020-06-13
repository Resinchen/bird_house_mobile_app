import 'package:birdhouseapp/domains/birdHouse.dart';
import 'package:birdhouseapp/widgets/birdHouseTile.dart';

import 'package:flutter/material.dart';

class ListBirdHouse extends StatefulWidget {
  @override
  _ListBirdHouseState createState() => _ListBirdHouseState();
}

class _ListBirdHouseState extends State<ListBirdHouse> {
  Map data = {};
  List<BirdHouse> birdHousesList;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    birdHousesList = data['birdHousesList'];

    return Scaffold(
        appBar: AppBar(
            title: Text('Список устройств'), backgroundColor: Colors.blue[900]),
        body: ListView.builder(
            itemCount: birdHousesList.length,
            itemBuilder: (context, index) {
              print(birdHousesList[index].idDevice);
              return BirdHouseTile(birdhouse: birdHousesList[index]);
            }));
  }
}
