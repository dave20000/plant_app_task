import 'package:flutter/material.dart';

class UIHelper {
  static Widget verticalDividerSmall() {
    return SizedBox(height: 8);
  }

  static Widget verticalDivider() {
    return SizedBox(height: 16);
  }

  static Widget horizontalDividerSmall() {
    return SizedBox(width: 8);
  }

  static Widget horizontalDivider() {
    return SizedBox(width: 16);
  }

  static Color darkgreencolor = Color.fromRGBO(103, 133, 73, 1.0);
  static Color lightgreencolor = Color.fromRGBO(228, 255, 212, 1.0);
  static Color amberColor = Colors.amber;
  static Color lightAmberColor = Colors.amberAccent.shade100;
  static const Color bottomSheetColor = Color(0xFFA0DB15);

  static double minCartItemBottomSheetHeight = 100;
}
