import 'package:flutter/material.dart';

class BackChessPieces extends CustomPainter {
  BackChessPieces({
    required this.spread,
  }) : super(repaint: spread);

  final AnimationController spread;

  double radius = 10;
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromARGB(253, 247, 247, 247);
    canvas.drawRect(const Offset(0, 0) & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
