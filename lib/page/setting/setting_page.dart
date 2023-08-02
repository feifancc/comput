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
        }
      ]
    }
  ];

  Color color = LayoutConfig.getCardColor();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('设置'),
      ),
      drawer: Container(
        color: const Color(0xffffffff),
        width: 400,
        child: Center(
          child: ColorSelector(
            color: color,
            height: 300,
            width: 300,
          ),
        ),
      ),
      drawerEdgeDragWidth: 300,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: ListView(
          children: path
              .map(
                (e) => RowLayout(pathChild: e, scaffoldKey: _scaffoldKey),
              )
              .toList(),
        ),
      ),
    );
  }
}
