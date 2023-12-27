import 'package:flutter/material.dart';

class PathPaint extends CustomPainter {
  final Animation<double> spread;

  PathPaint({required this.spread, required this.paths})
      : super(repaint: spread);

  List<Offset> paths;
  int get pathCount => paths.length;
  double get num => 1 / pathCount;

  @override
  void paint(Canvas canvas, Size size) {
    if (spread.value != 0) {
      Paint paint = Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.green;
      var path = Path();
      int index = 0;
      late Offset lastOffset;

      for (var offset in paths) {
        if (index == 0) {
          path.moveTo(offset.dx, offset.dy);
        } else {
          path.moveTo(lastOffset.dx, lastOffset.dy);
          if (spread.value >= (index - 1) * num && spread.value < index * num) {
            path.lineTo(
              lastOffset.dx +
                  (offset.dx - lastOffset.dx) *
                      (spread.value - (index - 1) * num) *
                      (1 / num),
              lastOffset.dy +
                  (offset.dy - lastOffset.dy) *
                      (spread.value - (index - 1) * num) *
                      (1 / num),
            );
          } else if (spread.value > index * num) {
            path.lineTo(offset.dx, offset.dy);
          }
        }
        lastOffset = offset;
        index++;
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant PathPaint oldDelegate) {
    return oldDelegate.spread != spread;
  }
}
