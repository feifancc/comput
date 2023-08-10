import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Native extends StatefulWidget {
  const Native({super.key});

  @override
  State<Native> createState() => _Native();
}

class _Native extends State<Native> {
  bool stateBar = true;
  bool showCom = true;

  @override
  Widget build(BuildContext context) {
    var Com = ListView(
      children: [
        Row(
          children: [
            const Text('切换状态栏: '),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  stateBar = !stateBar;
                });
                SystemChrome.setSystemUIOverlayStyle(stateBar
                    ? SystemUiOverlayStyle.dark
                    : SystemUiOverlayStyle.light);
              },
              child: Text(stateBar ? "显示" : '影藏'),
            ),
          ],
        ),
        Row(
          children: [
            const Text('切换视组件: '),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showCom = !showCom;
                });
              },
              child: Text(showCom ? "显示" : '影藏'),
            ),
          ],
        ),
      ],
    );
    return showCom
        ? SafeArea(
            child: Com,
          )
        : Com;
  }
}

class Data {
  Data({required this.text, required this.key});
  TextButton text;
  GlobalKey key;
}
