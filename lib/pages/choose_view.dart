import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:geolocator/geolocator.dart';

import 'package:birdhouseapp/services/birdHouseService.dart';

class ChooseView extends StatefulWidget {
  @override
  _ChooseViewState createState() => _ChooseViewState();
}

class _ChooseViewState extends State<ChooseView> {
  String _idDevice;
  Geolocator _geolocator;
  Position _position;
  BirdHouseService _instanceService;

  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) {
      print('status: $status');
    });
    _geolocator
        .checkGeolocationPermissionStatus(
            locationPermission: GeolocationPermission.locationAlways)
        .then((status) {
      print('always status: $status');
    });
    _geolocator
        .checkGeolocationPermissionStatus(
            locationPermission: GeolocationPermission.locationWhenInUse)
        .then((status) {
      print('whenInUse status: $status');
    });
  }

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        _idDevice = qrResult;
      });

      Position currPos = await _geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _position = currPos;
      });

      await _instanceService.registerDevice(_position, _idDevice);
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          _idDevice = "Camera permission was denied";
        });
      } else {
        setState(() {
          _idDevice = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        _idDevice = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        _idDevice = "Unknown Error $ex";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _geolocator = Geolocator();
    _instanceService = BirdHouseService();
    checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Text('Choose a View'),
            centerTitle: true,
            elevation: 0),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton.icon(
                  color: Colors.grey[50],
                  padding:
                      EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
                  onPressed: () {
                    Navigator.pushNamed(context, '/load',
                        arguments: {'route': '/map'});
                  },
                  icon: Icon(Icons.map),
                  label: Text('Map')),
              RaisedButton.icon(
                  color: Colors.grey[50],
                  padding:
                      EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
                  onPressed: () {
                    Navigator.pushNamed(context, '/load',
                        arguments: {'route': '/list'});
                  },
                  icon: Icon(Icons.list),
                  label: Text('List'))
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.camera_alt),
            label: Text("Новое устройство"),
            onPressed: _scanQR));
  }
}
