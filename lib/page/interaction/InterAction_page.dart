import 'package:flutter/material.dart';

class InterActionPage extends StatefulWidget {
  const InterActionPage({super.key});

  @override
  State<InterActionPage> createState() => _InterActionPage();
}

class _InterActionPage extends State<InterActionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Align(
            child: Text(
              'asdfsf',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
