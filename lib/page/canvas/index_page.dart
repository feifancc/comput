import 'dart:math';

import 'package:comput/page/canvas/widgets/select_color.dart';
import 'package:flutter/material.dart';

enum SELECTOR { main, secondary, opacity }

typedef SelectColor = void Function(Color color);

class CustomPaintRoute extends StatefulWidget {
  const CustomPaintRoute({super.key});

  @override
  State<CustomPaintRoute> createState() => _CustomPaintRouteState();
}

class _CustomPaintRouteState extends State<CustomPaintRoute>
    with SingleTickerProviderStateMixin {
  _CustomPaintRouteState();
  late AnimationController spread;
  @override
  void initState() {
    super.initState();
    spread =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..repeat();
  }

  @override
  void dispose() {
    spread.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canvas'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Center(
              child: CustomPaint(
                size: Size(120, 120),
                painter: ShapePainter(spread: spread),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final Animation<double> spread;

  ShapePainter({required this.spread}) : super(repaint: spread);

  @override
  void paint(Canvas canvas, Size size) {
    // final double smallRadius = size.width / 6;
    // const double spreadFactor = 2;

    if (spread.value != 0) {
      Paint _paint = Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.green;
      var path = Path();
      path.moveTo(0, 0);
      path.conicTo(120 - 120 * spread.value, 120 * spread.value, 120, 120, 2);
      canvas.drawPath(path, _paint);
      //   _paint..color = Colors.green.withOpacity(1 - spread.value);
      //   canvas.drawCircle(
      //       Offset(0, 0), smallRadius * (spreadFactor * spread.value), _paint);
    }
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) {
    return oldDelegate.spread != spread;
  }
}
