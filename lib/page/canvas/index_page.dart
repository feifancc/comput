import 'package:flutter/material.dart';

class CustomPaintRoute extends StatefulWidget {
  const CustomPaintRoute({super.key});
  @override
  State<CustomPaintRoute> createState() => _CustomPaintRouteState();
}

class _CustomPaintRouteState extends State<CustomPaintRoute>
    with SingleTickerProviderStateMixin {
  _CustomPaintRouteState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canvas'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: const [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10), child: Text('sdff')),
        ],
      ),
    );
  }
}
