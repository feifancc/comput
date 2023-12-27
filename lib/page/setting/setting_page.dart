import 'package:comput/widgets/SelectColor/select_color.dart';
import 'package:comput/page/setting/row_layout.dart';
import 'package:comput/state/layout_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _Setting();
}

class _Setting extends State<Setting> {
  void Function(Color cl)? setValueColor;
  Color? color;
  void setColor(Color c, void Function(Color cl) cb) {
    if (mounted) {
      setState(() {
        color = c;
        setValueColor = cb;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>>? path;
  @override
  Widget build(BuildContext context) {
    LayoutConfigState layoutConfigState = context.watch<LayoutConfigState>();
    path ??= layoutConfigState.getPath();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('设置'),
      ),
      onDrawerChanged: (b) {
        if (!b) {
          setState(() {
            color = null;
            setValueColor = null;
          });
        }
      },
      drawer: SafeArea(
        child: Container(
          color: const Color(0xffffffff),
          width: 400,
          child: Center(
            child: Column(
              children: [
                ColorSelector(
                  color: color ?? const Color(0xffffffff),
                  height: 300,
                  width: 300,
                  lineWidth: layoutConfigState.getColorSelectorMainLineWidth(),
                  conic: layoutConfigState.getColorSelectorMainConic(),
                  animationSpeed:
                      layoutConfigState.getColorSelectorAnimationSpeed(),
                  selectColor:
                      layoutConfigState.getColorSelectorSelerctdColor(),
                  onChanged: (cl) => setState(() => color = cl),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 30, 70, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () =>
                            _scaffoldKey.currentState?.openEndDrawer(),
                        icon: const Icon(Icons.cancel),
                        label: const Text('取消'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (setValueColor != null && color != null) {
                            setValueColor!(color!);
                            _scaffoldKey.currentState?.openEndDrawer();
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('確定'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      drawerEdgeDragWidth: 300,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: path!
              .map(
                (e) => RowLayout(
                  pathChild: e,
                  scaffoldKey: _scaffoldKey,
                  setColor: setColor,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
