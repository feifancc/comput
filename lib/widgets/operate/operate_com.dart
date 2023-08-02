import 'package:comput/widgets/operate/pressed_operate.dart';
import 'package:flutter/material.dart';

class FloatOperate extends StatelessWidget {
  const FloatOperate(
      {super.key, required this.top, required this.longPressedOperates});
  final double? top;
  final List<PressedOperate> longPressedOperates;
  @override
  Widget build(BuildContext context) {
    if (top != null) {
      final List<dynamic> renders = [];
      int index = 0;
      for (var element in longPressedOperates) {
        renders.add(element);
      }
      return Positioned(
        top: top,
        child: Container(
          color: Color.fromARGB(178, 10, 10, 10),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: longPressedOperates.map((e) => e.com).toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
