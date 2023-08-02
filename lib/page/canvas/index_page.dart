import 'package:comput/page/canvas/widgets/select_color.dart';
import 'package:flutter/material.dart';

enum SELECTOR { main, secondary, opacity }

typedef SelectColor = void Function(Color color);

class CustomPaintRoute extends StatefulWidget {
  const CustomPaintRoute({super.key});

  @override
  State<CustomPaintRoute> createState() => _CustomPaintRouteState();
}

class _CustomPaintRouteState extends State<CustomPaintRoute> {
  _CustomPaintRouteState();

  Color color = const Color(0xf0aaaaa0);

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
              child: ColorSelector(
                height: 300,
                width: 300,
                color: color,
                onChanged: (colr) => setState(() {
                  color = colr;
                }),
              ),
            ),
          ),
          Container(
            color: color,
            height: 600,
          ),
        ],
      ),
    );
  }
}
