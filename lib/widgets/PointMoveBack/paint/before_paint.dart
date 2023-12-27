import 'dart:math';

import 'package:flutter/material.dart';

class ForeChessPieces extends CustomPainter {
  ForeChessPieces({
    required this.spread,
    required this.points,
    required this.color1,
    required this.color2,
    required this.lineWidth,
    required this.pointRadius,
    required this.criticalLineLength,
    required this.lineWidth2,
  }) : super(repaint: spread);

  final AnimationController spread;

  final Color color1;

  final Color color2;

  final double lineWidth;

  final double lineWidth2;

  final double pointRadius;

  final double criticalLineLength;

  final List<PathPoint> points;

  Color get colorDiff => Color.fromRGBO(
        color1.red - color2.red,
        color1.green - color2.green,
        color1.blue - color2.blue,
        color1.opacity - color2.opacity,
      );

  late double frame = 0.1;

  drawLine(Offset of1, Offset of2, Canvas canvas, Path path) {
    if (of1 == of2) return;
    double lineLength = sqrt(pow(of2.dx - of1.dx, 2) + pow(of2.dy - of1.dy, 2));
    if (lineLength <= criticalLineLength) {
      var num = (lineLength - criticalLineLength).abs() / criticalLineLength;
      var width = lineWidth2 + (lineWidth - lineWidth2) * num;
      var color = Color.fromRGBO(
          (color2.red + num * colorDiff.red).toInt(),
          (color2.green + num * colorDiff.green).toInt(),
          (color2.blue + num * colorDiff.blue).toInt(),
          color2.opacity + num * colorDiff.opacity);

      final pathPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..color = color;
      path.lineTo(of1.dx, of1.dy);
      path.moveTo(of2.dx, of2.dy);
      canvas.drawPath(path, pathPaint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromARGB(255, 63, 63, 63);
    double num = spread.value;
    for (var i = 0; i < points.length; i++) {
      if (frame > num) {
        points[i].move(num);
      }
      var path = Path()..moveTo(points[i].offset.dx, points[i].offset.dy);
      for (var y = i; y < points.length; y++) {
        drawLine(points[y].offset, points[i].offset, canvas, path);
      }

      canvas.drawCircle(points[i].offset, pointRadius, paint);
    }
    frame = num;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class PathPoint {
  PathPoint({
    required this.offset,
    required this.targetOffset,
    required this.size,
    required this.oldOffset,
    required this.singleMove,
    required this.isMouse,
  });

  final Size size;
  Offset oldOffset;
  Offset offset;
  Offset targetOffset;
  Offset singleMove;
  final bool isMouse;

  void nextTargetOffset(Size size) {
    oldOffset = offset;
    double x, y;
    if (oldOffset.dx + 5 > size.width || oldOffset.dx - 5 < 0) {
      x = random(size.height.toInt());
      y = Random().nextInt(2) > 0 ? 0 : size.height;
    } else {
      x = Random().nextInt(2) > 0 ? 0 : size.width;
      y = random(size.height.toInt());
    }

    Offset newSingleMove;
    var xRoot = targetOffset.dx - offset.dx;
    var yRoot = targetOffset.dy - offset.dy;
    if (xRoot.abs() > yRoot.abs()) {
      newSingleMove =
          Offset((xRoot > 0 ? 1 : -1), yRoot == 0 ? 0 : yRoot / xRoot.abs());
    } else {
      newSingleMove =
          Offset(xRoot == 0 ? 0 : xRoot / yRoot.abs(), (yRoot > 0 ? 1 : -1));
    }
    singleMove = newSingleMove;
    targetOffset = Offset(x, y);
  }

  void move(double n) {
    if (isMouse) return;
    offset = Offset(offset.dx + singleMove.dx, offset.dy + singleMove.dy);
    if (offset.dx >= size.width || offset.dx <= 0) {
      return nextTargetOffset(size);
    }
    if (offset.dy >= size.height || offset.dy <= 0) {
      return nextTargetOffset(size);
    }
  }

  factory PathPoint.init(Size size, [bool isMouse = false]) {
    var offset =
        Offset(random(size.width.toInt()), random(size.height.toInt()));
    var targetOffset = Random().nextInt(2) > 0
        ? Offset(0, random(size.height.toInt()))
        : Offset(random(size.width.toInt()), 0);
    Offset singleMove;
    var xRoot = targetOffset.dx - offset.dx;
    var yRoot = targetOffset.dy - offset.dy;
    if (xRoot.abs() > yRoot.abs()) {
      singleMove =
          Offset((xRoot > 0 ? 1 : -1), yRoot == 0 ? 0 : yRoot / xRoot.abs());
    } else {
      singleMove =
          Offset(xRoot == 0 ? 0 : xRoot / yRoot.abs(), (yRoot > 0 ? 1 : -1));
    }
    return PathPoint(
      isMouse: isMouse,
      size: size,
      oldOffset: offset,
      offset: offset,
      singleMove: singleMove,
      targetOffset: targetOffset,
    );
  }

  static double random(int x) => Random().nextInt(x).toDouble();

  static List<PathPoint> batch({required Size size, required int count}) {
    List<PathPoint> points = [];
    for (var i = 0; i < count; i++) {
      points.add(PathPoint.init(size, false));
    }
    return points;
  }
}
