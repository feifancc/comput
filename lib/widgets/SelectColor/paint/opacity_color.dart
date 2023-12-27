import 'package:flutter/material.dart';

class OpacitySelector extends CustomPainter {
  OpacitySelector({
    this.r = 0,
    this.g = 0,
    this.b = 0,
    required this.blockSize,
    required this.context,
    required this.selectColor,
    required this.opacity,
  });
  int r;
  int g;
  int b;
  double opacity;

  Color selectColor;
  BuildContext context;
  Size blockSize;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i <= 10; i++) {
      var paint = Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..color = Color.fromRGBO(r, g, b, i / 10);
      canvas.drawRect(
          Offset(i * blockSize.width + i + 1, 0) & blockSize, paint);

      if (i / 10 == opacity) {
        var paint = Paint()
          ..isAntiAlias = true
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..color = selectColor;
        canvas.drawRect(
            Offset(i * blockSize.width + i + 1, 0) & blockSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
