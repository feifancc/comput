import 'package:flutter/material.dart';

enum OFFSET { h, w }

///
/// 前景
class MainCanvsPaintForeground extends CustomPainter {
  MainCanvsPaintForeground({
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

  double computeOffset(int x, {required OFFSET of}) =>
      (x ~/ 16).toDouble() *
      (1 + (of == OFFSET.h ? blockSize.height : blockSize.width));

  final double lineWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    var topPaint = Paint()
      ..strokeWidth = lineWidth
      ..color = selectColor;
    canvas.drawLine(Offset(0, computeOffset(g, of: OFFSET.h)),
        Offset(size.width, computeOffset(g, of: OFFSET.h)), topPaint);

    var leftPaint = Paint()
      ..strokeWidth = lineWidth
      ..color = selectColor;
    canvas.drawLine(Offset(computeOffset(r, of: OFFSET.w), 0),
        Offset(computeOffset(r, of: OFFSET.w), size.height), leftPaint);

    var bottomPaint = Paint()
      ..strokeWidth = lineWidth
      ..color = selectColor;
    canvas.drawLine(
        Offset(0, computeOffset(g, of: OFFSET.h) + blockSize.height + 1),
        Offset(
            size.width, computeOffset(g, of: OFFSET.h) + blockSize.height + 1),
        bottomPaint);

    var rightPaint = Paint()
      ..strokeWidth = lineWidth
      ..color = selectColor;
    canvas.drawLine(
        Offset(computeOffset(r, of: OFFSET.w) + blockSize.width + 1, 0),
        Offset(
            computeOffset(r, of: OFFSET.w) + blockSize.width + 1, size.height),
        rightPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
