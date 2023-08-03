import 'package:comput/page/canvas/widgets/select_color.dart';
import 'package:comput/page/setting/row_layout.dart';
import 'package:comput/util/layot_config.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _Setting();
}

class _Setting extends State<Setting> {
  List<Map<String, dynamic>> path = [
    {
      "title": '布局',
      'children': [
        {
          "label": "横向/纵向切换布局临界点",
          "type": 'input',
          "getValue": LayoutConfig.getVhPoint,
          "setValue": LayoutConfig.setVhPoint,
          "helpText": "整数,像素,默认750"
        },
        {
          "label": "展开菜单临界点",
          "type": 'input',
          "getValue": LayoutConfig.getCriticalPoint,
          "setValue": LayoutConfig.setCriticalPoint,
          "helpText": "整数,像素,默认900"
        },
        {
          "label": "菜单宽度",
          "type": 'input',
          "getValue": LayoutConfig.getMinExtendeWidth,
          "setValue": LayoutConfig.setMinExtendeWidth,
          "helpText": "浮点数,像素,最大256,默认150"
        },
      ]
    },
    {
      'title': '计算',
      'children': [
        {
          "label": "设置1/1布局",
          "type": 'input',
          "getValue": LayoutConfig.getComputLayoutWidth11,
          "setValue": LayoutConfig.setComputLayoutWidth11,
          "helpText": "浮点数,像素,默认600"
        },
        {
          "label": "设置1/2布局",
          "type": 'input',
          "getValue": LayoutConfig.getComputLayoutWidth12,
          "setValue": LayoutConfig.setComputLayoutWidth12,
          "helpText": "浮点数,像素,默认1100"
        },
        {
          "label": "设置1/3布局",
          "type": 'input',
          "getValue": LayoutConfig.getComputLayoutWidth13,
          "setValue": LayoutConfig.setComputLayoutWidth13,
          "helpText": "浮点数,像素,默认1500"
        },
        {
          "label": "设置1/4布局",
          "type": 'input',
          "getValue": LayoutConfig.getComputLayoutWidth14,
          "setValue": LayoutConfig.setComputLayoutWidth14,
          "helpText": "浮点数,像素,默认1800"
        },
      ]
    },
    {
      'title': "颜色",
      "children": [
        {
          'label': 'Card',
          'type': "color",
          'getValue': LayoutConfig.getCardColor,
          'setValue': LayoutConfig.setCardColor
        },
        {
          'label': 'Prime',
          'type': "color",
          'getValue': LayoutConfig.getPrimeColor,
          'setValue': LayoutConfig.setPrimeColor
        },
        {
          'label': 'disabled',
          'type': "color",
          'getValue': LayoutConfig.getDisabledColor,
          'setValue': LayoutConfig.setDisabledColor,
        },
        {
          'label': 'splash',
          'type': "color",
          'getValue': LayoutConfig.getSplashColor,
          'setValue': LayoutConfig.setSplashColor
        },
      ]
    }
  ];

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
  @override
  Widget build(BuildContext context) {
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
      drawer: Container(
        color: const Color(0xffffffff),
        width: 400,
        child: Center(
          child: Column(
            children: [
              ColorSelector(
                color: color ?? const Color(0xffffffff),
                height: 300,
                width: 300,
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
      drawerEdgeDragWidth: 300,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: path
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
