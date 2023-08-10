import 'package:flutter/material.dart';

enum OFFSET { h, w }

///
/// 前景
class MainCanvsPaintForeground extends CustomPainter {
  final Animation<double>? spread;

  MainCanvsPaintForeground({
    this.r = 0,
    this.g = 0,
    this.b = 0,
    this.or = 0,
    this.og = 0,
    this.ob = 0,
    this.spread,
    this.lineWidth = 2,
    this.conic = .5,
    required this.blockSize,
    required this.selectColor,
  }) : super(repaint: spread);

  /// rgb中r值颜色
  int r;

  /// rgb中g值颜色
  int g;

  /// rgb中b值颜色
  int b;

  /// 旧颜色 rgb中r值颜色
  int? or;

  /// 旧颜色 rgb中g值颜色
  int? og;

  /// 旧颜色 rgb中b值颜色
  int? ob;

  /// 选中框颜色
  Color selectColor;

  /// 选中框线条宽度
  double lineWidth;

  /// 主颜色选择器动画线条圆弧值
  double conic;

  double jie = 0.7;

  /// 容器大小
  Size blockSize;

  double computeOffset(int x, {required OFFSET of}) =>
      (x ~/ 16).toDouble() *
      (1 + (of == OFFSET.h ? blockSize.height : blockSize.width));

  @override
  void paint(Canvas canvas, Size size) {
    if (spread != null && spread?.value != 1) {
      /// INFO: 动画开始
      double toY =
          computeOffset(g, of: OFFSET.h) - computeOffset(og!, of: OFFSET.h);
      double toX =
          computeOffset(r, of: OFFSET.w) - computeOffset(or!, of: OFFSET.w);

      /// 上线条
      var topPaint = Paint()
        ..strokeWidth = lineWidth
        ..style = PaintingStyle.stroke
        ..color = selectColor;
      var topPath = Path();
      topPath.moveTo(
          0,
          spread!.value < jie
              ? computeOffset(og!, of: OFFSET.h) + toY * spread!.value * 1 / jie
              : computeOffset(g, of: OFFSET.h));
      topPath.conicTo(
          spread!.value < jie
              ? computeOffset(or!, of: OFFSET.w)
              : computeOffset(or!, of: OFFSET.w) +
                  (toX * spread!.value * (spread!.value - jie) * 1 / (1 - jie)),
          spread!.value < jie
              ? computeOffset(og!, of: OFFSET.h)
              : computeOffset(og!, of: OFFSET.h) +
                  (toY * spread!.value * (spread!.value - jie) * 1 / (1 - jie)),
          size.width,
          spread!.value < jie
              ? computeOffset(og!, of: OFFSET.h) + toY * spread!.value * 1 / jie
              : computeOffset(g, of: OFFSET.h),
          conic);
      canvas.drawPath(topPath, topPaint);

      /// 左线条
      var leftPaint = Paint()
        ..strokeWidth = lineWidth
        ..style = PaintingStyle.stroke
        ..color = selectColor;
      var leftPath = Path();
      leftPath.moveTo(
          spread!.value < jie
              ? computeOffset(or!, of: OFFSET.w) + toX * spread!.value * 1 / jie
              : computeOffset(r, of: OFFSET.w),
          0);
      leftPath.conicTo(
          spread!.value < jie
              ? computeOffset(or!, of: OFFSET.w)
              : computeOffset(or!, of: OFFSET.w) +
                  (toX * spread!.value * (spread!.value - jie) * 1 / (1 - jie)),
          spread!.value < jie
              ? computeOffset(og!, of: OFFSET.h)
              : computeOffset(og!, of: OFFSET.h) +
                  (toY * spread!.value * (spread!.value - jie) * 1 / (1 - jie)),
          spread!.value < jie
              ? computeOffset(or!, of: OFFSET.w) + toX * spread!.value * 1 / jie
              : computeOffset(r, of: OFFSET.w),
          size.height,
          conic);
      canvas.drawPath(leftPath, leftPaint);

      /// 下线条
      var bottomPaint = Paint()
        ..strokeWidth = lineWidth
        ..style = PaintingStyle.stroke
        ..color = selectColor;
      var bottomPath = Path();
      bottomPath.moveTo(
          0,
          (spread!.value < jie
                  ? computeOffset(og!, of: OFFSET.h) +
                      toY * spread!.value * 1 / jie
                  : computeOffset(g, of: OFFSET.h)) +
              blockSize.height +
              1);
      bottomPath.conicTo(
          spread!.value < jie
              ? computeOffset(or!, of: OFFSET.w)
              : computeOffset(or!, of: OFFSET.w) +
                  (toX * spread!.value * (spread!.value - jie) * 1 / (1 - jie)),
          (spread!.value < jie
                  ? computeOffset(og!, of: OFFSET.h)
                  : computeOffset(og!, of: OFFSET.h) +
                      (toY *
                          spread!.value *
                          (spread!.value - jie) *
                          1 /
                          (1 - jie))) +
              blockSize.height +
              1,
          size.width,
          (spread!.value < jie
                  ? computeOffset(og!, of: OFFSET.h) +
                      toY * spread!.value * 1 / jie
                  : computeOffset(g, of: OFFSET.h)) +
              blockSize.height +
              1,
          conic);
      canvas.drawPath(bottomPath, bottomPaint);

      /// 右线条
      var rightPaint = Paint()
        ..strokeWidth = lineWidth
        ..style = PaintingStyle.stroke
        ..color = selectColor;
      var rightPath = Path();
      rightPath.moveTo(
          (spread!.value < jie
                  ? computeOffset(or!, of: OFFSET.w) +
                      toX * spread!.value * 1 / jie
                  : computeOffset(r, of: OFFSET.w)) +
              blockSize.width +
              1,
          0);
      rightPath.conicTo(
          (spread!.value < jie
                  ? computeOffset(or!, of: OFFSET.w)
                  : computeOffset(or!, of: OFFSET.w) +
                      (toX *
                          spread!.value *
                          (spread!.value - jie) *
                          1 /
                          (1 - jie))) +
              blockSize.width +
              1,
          spread!.value < jie
              ? computeOffset(og!, of: OFFSET.h)
              : computeOffset(og!, of: OFFSET.h) +
                  (toY * spread!.value * (spread!.value - jie) * 1 / (1 - jie)),
          (spread!.value < jie
                  ? computeOffset(or!, of: OFFSET.w) +
                      toX * spread!.value * 1 / jie
                  : computeOffset(r, of: OFFSET.w)) +
              blockSize.width +
              1,
          size.height,
          conic);
      canvas.drawPath(rightPath, rightPaint);
    } else {
      /// INFO: 动画结束
      // 上线条
      var topPaint = Paint()
        ..strokeWidth = lineWidth
        ..color = selectColor;
      canvas.drawLine(
        Offset(0, computeOffset(g, of: OFFSET.h)),
        Offset(size.width, computeOffset(g, of: OFFSET.h)),
        topPaint,
      );

      // 左线条
      var leftPaint = Paint()
        ..strokeWidth = lineWidth
        ..color = selectColor;
      canvas.drawLine(
        Offset(computeOffset(r, of: OFFSET.w), 0),
        Offset(computeOffset(r, of: OFFSET.w), size.height),
        leftPaint,
      );

      // 下线条
      var bottomPaint = Paint()
        ..strokeWidth = lineWidth
        ..color = selectColor;
      canvas.drawLine(
        Offset(0, computeOffset(g, of: OFFSET.h) + blockSize.height + 1),
        Offset(
            size.width, computeOffset(g, of: OFFSET.h) + blockSize.height + 1),
        bottomPaint,
      );

      // 右线条
      var rightPaint = Paint()
        ..strokeWidth = lineWidth
        ..color = selectColor;
      canvas.drawLine(
        Offset(computeOffset(r, of: OFFSET.w) + blockSize.width + 1, 0),
        Offset(
            computeOffset(r, of: OFFSET.w) + blockSize.width + 1, size.height),
        rightPaint,
      );
    }
  }

  @override
  bool shouldRepaint(oldDelegate) {
    return true;
  }
}
