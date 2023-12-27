import 'package:comput/widgets/PointMoveBack/paint/before_paint.dart';
import 'package:comput/state/layout_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SELECTOR { main, secondary, opacity }

typedef SelectColor = void Function(Color color);

Size size = const Size(400, 400);

class PointMoveBack extends StatefulWidget {
  const PointMoveBack({
    super.key,
    this.size = const Size(400, 400),
    this.ms = 2,
    this.pointCount = 8,
    this.child,
  });
  final Size size;
  final int pointCount;
  final int ms;
  final Widget? child;

  @override
  State<PointMoveBack> createState() => _PointMoveBack();
}

class _PointMoveBack extends State<PointMoveBack>
    with SingleTickerProviderStateMixin {
  _PointMoveBack();
  late AnimationController spread;
  GlobalKey beforeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    points = PathPoint.batch(size: size, count: widget.pointCount);
    spread = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2))
      ..repeat();
  }

  @override
  void dispose() {
    spread.dispose();
    super.dispose();
  }

  late List<PathPoint> points;

  @override
  Widget build(BuildContext context) {
    // const paths = [
    //   Offset(90, 100),
    //   Offset(170, 100),
    //   Offset(100, 150),
    //   Offset(130, 70),
    //   Offset(160, 150),
    //   Offset(90, 100),
    // ];
    LayoutConfigState layoutConfigState = context.watch<LayoutConfigState>();
    return MouseRegion(
      onHover: (e) {
        RenderBox? box =
            beforeKey.currentContext?.findRenderObject() as RenderBox?;
        if (box != null && points[points.length - 1].isMouse) {
          var offset = box.localToGlobal(Offset.zero);
          var mouseOffset = e.position - offset;
          points[points.length - 1].offset =
              Offset(mouseOffset.dx, mouseOffset.dy);
        }
      },
      onEnter: (e) => points.add(PathPoint.init(size, true)),
      onExit: (e) => points.removeAt(points.length - 1),
      child: CustomPaint(
        key: beforeKey,
        size: widget.size,
        painter: ForeChessPieces(
            points: points,
            color1: layoutConfigState.getGridAnimationLineColorOne(),
            color2: layoutConfigState.getGridAnimationLineColorTwo(),
            lineWidth: layoutConfigState.getGridAnimationLineWidth(),
            pointRadius: layoutConfigState.getGridAnimationPointRadius(),
            lineWidth2: layoutConfigState.getGridAnimationLineWidthTwo(),
            spread: spread,
            criticalLineLength: 300),
        child: widget.child,
      ),
    );
  }
}
