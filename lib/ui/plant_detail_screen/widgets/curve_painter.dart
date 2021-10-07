import 'package:dynamic_widget_app_task/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = UIHelper.darkgreencolor; // 118, 151, 74
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width * 0.3, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.05, size.height * 0.5, 0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
