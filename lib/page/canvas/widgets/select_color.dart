import 'package:comput/page/canvas/widgets/SelectColor/paint/main_color_back.dart';
import 'package:comput/page/canvas/widgets/SelectColor/paint/main_color_fore.dart';
import 'package:comput/page/canvas/widgets/SelectColor/paint/opacity_color.dart';
import 'package:comput/page/canvas/widgets/SelectColor/paint/secondary_color.dart';
import 'package:flutter/material.dart';

enum SELECTOR { main, secondary, opacity }

typedef SelectColor = void Function(Color color);

class ColorSelector extends StatefulWidget {
  ColorSelector({
    super.key,
    this.onMainColorChanged,
    this.onSecondaryColorChanged,
    this.onOpacityColorChanged,
    this.onChanged,
    this.selectColor,
    required this.color,
    this.height,
    this.width,
  });

  /// 主色板选择时回调
  final SelectColor? onMainColorChanged;

  /// 辅色板选择时回调
  final SelectColor? onSecondaryColorChanged;

  /// 透明度色板选择时回调
  final SelectColor? onOpacityColorChanged;

  /// 选中状态边框颜色
  final Color? selectColor;

  /// 整个画板区域宽度
  final double? width;

  /// 整个画板区域高度
  final double? height;

  /// 任意画板选择回调
  Color color;

  final SelectColor? onChanged;

  @override
  State<ColorSelector> createState() => _ColorSelector();
}

class _ColorSelector extends State<ColorSelector> {
  _ColorSelector();

  @override
  void initState() {
    width = widget.width ?? 400;
    height = widget.height ?? 400;
    r = widget.color.red ~/ 16;
    g = widget.color.green ~/ 16;
    b = widget.color.blue ~/ 16;
    opacity = widget.color.opacity;

    selectColor = widget.selectColor ?? const Color.fromARGB(255, 250, 205, 4);
    super.initState();
  }

  late double width;
  late double height;
  late int r;
  late int g;
  late int b;
  late double opacity;
  late Color selectColor;

  void onSelected(SELECTOR selector) {
    Color color = Color.fromRGBO(r, g, b, opacity);
    if (widget.onChanged != null) {
      widget.onChanged!(color);
    }
    switch (selector) {
      case SELECTOR.main:
        if (widget.onMainColorChanged != null) {
          widget.onMainColorChanged!(color);
        }
        break;
      case SELECTOR.secondary:
        if (widget.onSecondaryColorChanged != null) {
          widget.onSecondaryColorChanged!(color);
        }
        break;
      case SELECTOR.opacity:
        if (widget.onOpacityColorChanged != null) {
          widget.onOpacityColorChanged!(color);
        }
        break;
    }
  }

  Size get mainSize => Size(width * .8, height * .8);
  Size get secondarySize => Size(blockSize.width, height * .8);
  Size get opacitySize => Size(blockSize.width * 11 + 11, blockSize.height);
  Size get blockSize =>
      Size((mainSize.width - 16) / 16, (mainSize.height - 16) / 16);

  final mainCanvasKey = GlobalKey();
  final secondaryCanvasKey = GlobalKey();
  final opacitySelectorKey = GlobalKey();

  Offset getOffsetByKey(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      Offset of = box.globalToLocal(Offset.zero);
      return of;
    }
    return Offset.zero;
  }

  int getCode(double num, {int i = 0, required OFFSET fx}) {
    num -= (fx == OFFSET.h ? blockSize.height : blockSize.width) + 1;
    if (num < 0) {
      return i;
    } else {
      return getCode(num, i: ++i, fx: fx);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///
                /// 主选择器
                ///
                GestureDetector(
                  key: mainCanvasKey,
                  onTapUp: (e) {
                    Offset boxOffset = getOffsetByKey(mainCanvasKey);
                    var currentOffset = e.globalPosition;
                    var y =
                        getCode(currentOffset.dy + boxOffset.dy, fx: OFFSET.h) *
                            16;
                    var x =
                        getCode(currentOffset.dx + boxOffset.dx, fx: OFFSET.w) *
                            16;
                    setState(() {
                      r = x.toInt();
                      g = y.toInt();
                    });
                    onSelected(SELECTOR.main);
                  },
                  child: CustomPaint(
                    size: mainSize, //指定画布大小
                    painter: MainCanvasPaintBackground(
                      r: r,
                      g: g,
                      b: b,
                      blockSize: blockSize,
                      context: context,
                      selectColor: selectColor,
                    ),
                    foregroundPainter: MainCanvsPaintForeground(
                        r: r,
                        g: g,
                        b: b,
                        blockSize: blockSize,
                        context: context,
                        selectColor: selectColor),
                  ),
                ),

                ///
                /// 辅选择器
                ///
                GestureDetector(
                  onTapUp: (e) {
                    Offset boxOffset = getOffsetByKey(secondaryCanvasKey);
                    var currentOffset = e.globalPosition;
                    var y =
                        getCode(currentOffset.dy + boxOffset.dy, fx: OFFSET.h) *
                            16;
                    setState(() {
                      b = y.toInt();
                    });
                    onSelected(SELECTOR.secondary);
                  },
                  child: CustomPaint(
                    key: secondaryCanvasKey,
                    size: secondarySize,
                    painter: SecondaryColor(
                      blockSize: blockSize,
                      context: context,
                      r: r,
                      g: g,
                      b: b,
                      selectColor: selectColor,
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///
                /// 示例颜色
                ///
                Container(
                  height: height * .1,
                  width: width * .3,
                  color: Color.fromRGBO(r, g, b, opacity),
                ),

                ///
                /// 透明度选择器
                ///
                GestureDetector(
                  key: opacitySelectorKey,
                  onTapUp: (e) {
                    Offset boxOffset = getOffsetByKey(opacitySelectorKey);
                    var currentOffset = e.globalPosition;
                    var opa =
                        getCode(currentOffset.dx + boxOffset.dx, fx: OFFSET.w);
                    setState(() {
                      opacity = (opa / 10).toDouble();
                    });
                    onSelected(SELECTOR.opacity);
                  },
                  child: CustomPaint(
                    size: opacitySize,
                    painter: OpacitySelector(
                      blockSize: blockSize,
                      context: context,
                      r: r,
                      g: g,
                      b: b,
                      opacity: opacity,
                      selectColor: selectColor,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
