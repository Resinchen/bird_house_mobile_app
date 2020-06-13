import 'package:birdhouseapp/domains/birdHouse.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';

class BirdHouseService {
  List<BirdHouse> birdHousesList;

  List<BirdHouse> parseData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<BirdHouse>((json) => BirdHouse.fromJson(json)).toList();
  }

  Future<void> getData() async {
    try {
      Response response = await get('http://api.server.address/api/mobile');
      birdHousesList = parseData(response.body);

      print(birdHousesList[0].address);
    } catch (e) {
      print('caught error $e');
      birdHousesList = [];
    }
  }

  Future<Response> registerDevice(Position position, String idDevice) {
    Map<String, String> body = {
      '_id': idDevice,
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString()
    };

    var bodyEncoded = json.encode(body);
    return post('http://api.server.address/api/mobile',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: bodyEncoded);
  }
}
