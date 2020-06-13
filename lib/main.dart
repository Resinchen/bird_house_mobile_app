import 'package:birdhouseapp/pages/choose_view.dart';
import 'package:birdhouseapp/pages/listBH.dart';
import 'package:birdhouseapp/pages/loading.dart';
import 'package:birdhouseapp/pages/mapBH.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ChooseView(),
        '/load': (context) => Loading(),
        '/list': (context) => ListBirdHouse(),
        '/map': (context) => MapBirdHouse(),
      },
    )
);
