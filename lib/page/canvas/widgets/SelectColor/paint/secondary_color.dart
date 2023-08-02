import 'package:flutter/material.dart';

class SecondaryColor extends CustomPainter {
  SecondaryColor({
    this.r = 0,
    this.g = 0,
    this.b = 0,
    required this.blockSize,
    required this.context,
    required this.selectColor,
  });
  int r;
  int g;
  int b;
  BuildContext context;
  Color selectColor;

  Size blockSize;
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 16; i++) {
      var paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..color = Color.fromRGBO(r, g, i * 16, 1);
      canvas.drawRect(
          Offset(0, i * blockSize.height + i + 1) & blockSize, paint);
      if (b == i * 16) {
        var paint = Paint()
          ..isAntiAlias = true
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..color = selectColor;
        canvas.drawRect(Offset(0, i * blockSize.height + i) & blockSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
