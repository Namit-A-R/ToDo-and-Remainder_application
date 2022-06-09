import 'package:flutter/material.dart';

class ColorManager{
  static Color primaryLight = HexColor.fromHex("#7900FF");
  static Color primaryDark = HexColor.fromHex("#d17d11");
  static Color darkGrey = HexColor.fromHex('#525252');
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");


  static Color blue = HexColor.fromHex("#5902EC");
  static Color disabledColor = HexColor.fromHex("#707070");
  static Color error = HexColor.fromHex("#e61f34");

  //FrameColors
  static Color frameColorLight = HexColor.fromHex("#5902EC");
  static Color frameColorDark = HexColor.fromHex("#5902EC");


  //DashBoardColors
  static Color dashboardBlack = Colors.black;
  static Color dashboardWhite = HexColor.fromHex("#FFFFFF");

  //bottom sheet colors
  static Color bottomSheetBlue = HexColor.fromHex("#2D31FA");
  static Color bottomSheetRed = HexColor.fromHex("#FF1818");
  static Color bottomSheetClose = HexColor.fromHex("#D9534F");

  //Three Way Color Scheme
  static Color green = HexColor.fromHex("#519259");
  static Color red = HexColor.fromHex("#FF1700");
  static Color orange = HexColor.fromHex("#D06224");


}

extension HexColor on Color{
  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll("#", "");
    if(hexColorString.length == 6){
      hexColorString = "FF"+hexColorString; //Opacity 100%
    }
    return Color(int.parse(hexColorString,radix: 16));
  }
}