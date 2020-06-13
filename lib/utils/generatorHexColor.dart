import 'package:flutter/material.dart';

class GeneratorHexColor {
  static const Color one = Color(0xff845bef);
  static const Color two = Color(0xfff8b250);
  static const Color three = Color(0xff0293ee);

  static List<Color> hexColor = [one, two, three];

  static int index = 0;

  static Color generate() {
    return hexColor[index++ % 3];
  }
}
