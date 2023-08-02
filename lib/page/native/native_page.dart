import 'dart:async';
import 'package:comput/widgets/operate/pressed_operate.dart';
import 'package:comput/widgets/operate/pressed_operate_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Native extends StatefulWidget {
  const Native({super.key});

  @override
  State<Native> createState() => _Native();
}

class _Native extends State<Native> {
  TextEditingController contr = TextEditingController();

  int w1 = 1;
  int w2 = 99;
  late Timer timer;

  void methodPressed(PressedOperateState state) {
    setState(() {
      top = null;
    });
    switch (state.label) {
      case '赞':
        break;
      case '复制':
        Clipboard.setData(ClipboardData(text: currentLabel ?? ''));
        break;
      case '撤回':
        break;
      case '搜索':
        break;
      case '取消':
        break;
      default:
    }
  }

  List<PressedOperateState> pressStates = [
    PressedOperateState(label: '赞'),
    PressedOperateState(label: '复制'),
    PressedOperateState(label: '撤回'),
    PressedOperateState(label: '搜索'),
    PressedOperateState(label: '取消'),
  ];
  late List<PressedOperate> longPressedOperates;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 1000), (time) {
      try {
        if (w1 < 100) {
          setState(() {
            w1 = w1 + 1;
            w2 = 100 - w1;
            contr.text = "$w1";
          });
        } else {
          timer.cancel();
        }
      } catch (e) {
        return;
      }
    });

    longPressedOperates = pressStates
        .map((str) => PressedOperate(
              str,
              onPressed: str.methodPressed ?? methodPressed,
            ))
        .toList();

    List<Data> lista = [];
    for (int i = 1; i <= 5; i++) {
      final label = '$feifan$i';
      final GlobalKey key = GlobalKey();
      TextButton text = TextButton(
        key: key,
        onLongPress: () {
          RenderBox? colObj =
              key.currentContext?.findRenderObject() as RenderBox?;
          RenderBox? stackObj =
              _stackKey.currentContext?.findRenderObject() as RenderBox?;

          if (colObj != null && stackObj != null) {
            var colOffset = colObj.localToGlobal(Offset.zero);
            var stackOffset = stackObj.localToGlobal(Offset.zero);
            setState(() {
              top = colOffset.dy - stackOffset.dy - colObj.size.height;
              currentLabel = label;
            });
          }
        },
        onPressed: () {},
        child: Text(label),
      );
      lista.add(Data(text: text, key: key));
    }
    texts = lista;

    super.initState();
  }

  final GlobalKey _stackKey = GlobalKey();

  String feifan = 'feifan';

  String? currentLabel;
  double? top;

  List<Data> texts = [];

  PointerEvent? offset;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          TextField(
            decoration: const InputDecoration(label: Text('label')),
            controller: contr,
            onChanged: (str) {
              try {
                int num = int.parse(str);
                setState(() {
                  w1 = num;
                  w2 = 100 - w1;
                });
              } catch (e) {
                return;
              }
            },
          ),
          Row(
            children: [
              Expanded(
                flex: w1,
                child: Container(
                  width: 0.1,
                  height: 20,
                  color: const Color(0xff600000),
                ),
              ),
              Expanded(
                flex: w2,
                child: Container(
                  width: 0.1,
                  height: 20,
                  color: const Color(0xffffffff),
                ),
              ),
            ],
          ),
          Stack(
            key: _stackKey,
            alignment: Alignment.topLeft,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Flex(
                  direction: Axis.vertical,
                  children: texts
                      .map(
                        (e) => e.text,
                      )
                      .toList(),
                ),
              ),
              if (top != null)
                Positioned(
                    top: top,
                    child: Container(
                      color: const Color.fromARGB(255, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            longPressedOperates.map((e) => e.com).toList(),
                      ),
                    ))
              else
                Container(),
            ],
          )
        ],
      ),
    );
  }
}

class Data {
  Data({required this.text, required this.key});
  TextButton text;
  GlobalKey key;
}
