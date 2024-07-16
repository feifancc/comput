import 'dart:math'; // 导入 Dart 的数学库
import 'package:flutter/material.dart'; // 导入 Flutter 的 Material 库

// 自定义绘画类，用于绘制动画效果
class ForeChessPieces extends CustomPainter {
  ForeChessPieces({
    required this.spread, // 动画控制器，用于控制动画进度
    required this.points, // 路径点列表
    required this.color1, // 起始颜色
    required this.color2, // 结束颜色
    required this.lineWidth, // 初始线宽
    required this.pointRadius, // 点的半径
    required this.criticalLineLength, // 临界线长度
    required this.lineWidth2, // 最小线宽
  }) : super(repaint: spread); // 绑定动画控制器，使其重绘

  final AnimationController spread; // 动画控制器
  final Color color1; // 起始颜色
  final Color color2; // 结束颜色
  final double lineWidth; // 初始线宽
  final double lineWidth2; // 最小线宽
  final double pointRadius; // 点的半径
  final double criticalLineLength; // 临界线长度
  final List<PathPoint> points; // 路径点列表

  late double frame = 0.1; // 帧速率，用于控制动画的更新

  // 绘制线条的方法
  void drawLine(Offset of1, Offset of2, Canvas canvas) {
    var path = Path()..moveTo(of2.dx, of2.dy); // 创建路径并移动到点的位置
    double lineLength =
        sqrt(pow(of2.dx - of1.dx, 2) + pow(of2.dy - of1.dy, 2)); // 计算线条长度
    if (lineLength <= criticalLineLength) {
      // 如果线条长度小于临界长度
      var colorRate = (lineLength - criticalLineLength).abs() /
          criticalLineLength; // 计算颜色比例
      var opRate = colorRate > 1 / 4 ? 1 : colorRate * 4; // 计算透明度比例
      var width = lineWidth2 + (lineWidth - lineWidth2) * colorRate; // 根据比例计算线宽
      var color = Color.fromRGBO(
        (color1.red + (color2.red - color1.red) * colorRate).round(),
        (color1.green + (color2.green - color1.green) * colorRate).round(),
        (color1.blue + (color2.blue - color1.blue) * colorRate).round(),
        color1.opacity + opRate,
      ); // 根据比例计算颜色
      // 初始化画笔对象
      final pathPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..color = color;
      path.lineTo(of1.dx, of1.dy); // 在路径上添加线条
      canvas.drawPath(path, pathPaint); // 绘制路径
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 初始化画笔对象
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color.fromARGB(255, 63, 63, 63); // 设置默认颜色
    double num = spread.value; // 获取动画控制器的当前值
    for (var i = 0; i < points.length; i++) {
      if (frame > num) {
        points[i].move(num); // 移动点
      }
      for (var y = i; y < points.length; y++) {
        if (y != i) {
          drawLine(points[y].offset, points[i].offset, canvas); // 绘制线条
        }
      }
      canvas.drawCircle(points[i].offset, pointRadius, paint); // 绘制圆圈
    }
    frame = num; // 更新帧速率
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // 表示是否需要重绘
  }
}

// 路径点类，表示一个动画点的位置和移动状态
class PathPoint {
  PathPoint({
    required this.offset, // 当前偏移量
    required this.targetOffset, // 目标偏移量
    required this.size, // 画布大小
    required this.oldOffset, // 旧的偏移量
    required this.singleMove, // 单步移动量
    required this.isMouse, // 是否是鼠标点
  });

  final Size size; // 画布大小
  Offset oldOffset; // 旧的偏移量
  Offset offset; // 当前偏移量
  Offset targetOffset; // 目标偏移量
  Offset singleMove; // 单步移动量
  final bool isMouse; // 是否是鼠标点

  // 计算下一个目标偏移量
  void nextTargetOffset(Size size) {
    oldOffset = offset; // 更新旧的偏移量
    double x, y;
    if (oldOffset.dx + 5 > size.width || oldOffset.dx - 5 < 0) {
      // 如果接近边缘，随机生成新的目标点
      x = random(size.height.toInt());
      y = Random().nextInt(2) > 0 ? 0 : size.height;
    } else {
      x = Random().nextInt(2) > 0 ? 0 : size.width;
      y = random(size.height.toInt());
    }

    // 计算新的单步移动量
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
    singleMove = newSingleMove; // 更新单步移动量
    targetOffset = Offset(x, y); // 更新目标偏移量
  }

  // 移动点的方法
  void move(double n) {
    if (isMouse) return; // 如果是鼠标点，不移动
    // 更新当前偏移量
    offset =
        Offset(offset.dx + singleMove.dx * n, offset.dy + singleMove.dy * n);
    // 如果超出边界，重新计算目标偏移量
    if (offset.dx >= size.width || offset.dx <= 0) {
      return nextTargetOffset(size);
    }
    if (offset.dy >= size.height || offset.dy <= 0) {
      return nextTargetOffset(size);
    }
  }

  // 初始化路径点
  factory PathPoint.init(Size size, [bool isMouse = false]) {
    var offset = Offset(
        random(size.width.toInt()), random(size.height.toInt())); // 随机生成初始偏移量
    var targetOffset = Random().nextInt(2) > 0
        ? Offset(0, random(size.height.toInt()))
        : Offset(random(size.width.toInt()), 0); // 随机生成目标偏移量
    Offset singleMove;
    var xRoot = targetOffset.dx - offset.dx;
    var yRoot = targetOffset.dy - offset.dy;
    // 计算初始单步移动量
    if (xRoot.abs() > yRoot.abs()) {
      singleMove =
          Offset((xRoot > 0 ? 1 : -1), yRoot == 0 ? 0 : yRoot / xRoot.abs());
    } else {
      singleMove =
          Offset(xRoot == 0 ? 0 : xRoot / yRoot.abs(), (yRoot > 0 ? 1 : -1));
    }
    return PathPoint(
      isMouse: isMouse, // 是否是鼠标点
      size: size, // 画布大小
      oldOffset: offset, // 旧的偏移量
      offset: offset, // 当前偏移量
      singleMove: singleMove, // 单步移动量
      targetOffset: targetOffset, // 目标偏移量
    );
  }

  // 生成随机数的方法
  static double random(int x) => Random().nextInt(x).toDouble();

  // 批量生成路径点
  static List<PathPoint> batch({required Size size, required int count}) {
    List<PathPoint> points = [];
    for (var i = 0; i < count; i++) {
      points.add(PathPoint.init(size, false)); // 生成指定数量的路径点
    }
    return points;
  }
}
