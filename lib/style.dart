import 'package:flutter/material.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class Style {
 static Color grey = "#8C86AA".toColor();
 static Color yellow = "#EFEA5A".toColor();
 static Color textColor = "#172A3A".toColor();
 static Color lightGrey =  "#707070".toColor();
 static Color green = "#16DB93".toColor();
 static Color pink = "#A4036F".toColor();
}