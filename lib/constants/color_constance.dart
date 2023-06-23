import 'package:flutter/material.dart';

class CustomeColor{

static const  main_bg=Color(0xFF015092);
static const  sub_bg=Color(0xFF1C5F83);
static Color saveAmountColor = HexColor("11875b") ;

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}