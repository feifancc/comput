import 'package:flutter/material.dart';

///
/// 背景
class MainCanvasPaintBackground extends CustomPainter {
  MainCanvasPaintBackground({
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

  Color selectColor;
  BuildContext context;
  Size blockSize;

  @override
  void paint(Canvas canvas, Size size) {
    for (var x = 0; x < 16; x++) {
      for (var y = 0; y < 16; y++) {
        var paint = Paint()
          ..isAntiAlias = true
          ..style = PaintingStyle.fill
          ..color = Color.fromRGBO(x * 16, y * 16, b, 1);
        canvas.drawRect(
            (Offset(x * blockSize.width + x + 1, y * blockSize.height + y + 1) &
                blockSize),
            paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
