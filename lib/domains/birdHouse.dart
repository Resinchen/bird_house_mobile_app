import 'package:birdhouseapp/presentation/custom_icons_icons.dart';
import 'package:flutter/material.dart';

import 'address.dart';
import 'location.dart';

class BirdHouse {
  String idDevice;
  Address address;

  DateTime dateCreated;

  Location location;

  Map<String, int> visiters;

  double filled;

  Icon getFilled() {
    if (filled <= .0) {
      return Icon(CustomIcons.battery_0);
    } else if (filled <= .3) {
      return Icon(CustomIcons.battery_25);
    } else if (filled <= .5) {
      return Icon(CustomIcons.battery_50);
    } else if (filled <= .7) {
      return Icon(CustomIcons.battery_75);
    } else {
      return Icon(CustomIcons.battery_100);
    }
  }

  BirdHouse(
      {this.idDevice,
      this.address,
      this.location,
      this.visiters,
      this.filled,
      this.dateCreated});

  factory BirdHouse.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> tempVisit = json['visiters'] as Map<String, dynamic>;
    Map<String, int> visit = tempVisit.cast<String, int>();
    Map<String, dynamic> jsonLocation =
        json['location'] as Map<String, dynamic>;

    return BirdHouse(
        idDevice: json['id_device'] as String,
        address: Address.fromJson(json['address'] as Map<String, dynamic>),
        location: Location.fromJson(jsonLocation),
        visiters: visit,
        filled: double.parse(json['filled'].toString()),
        dateCreated: DateTime.parse(json['date_created']));
  }
}
