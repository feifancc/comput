// ignore_for_file: non_constant_identifier_names

import 'package:comput/state/school_state.dart';
import 'package:comput/util/layot_config.dart';
import 'package:comput/util/util.dart';
import 'package:flutter/material.dart';

class School extends StatefulWidget {
  const School({super.key});

  @override
  State<School> createState() => _SchoolState();
}

class _SchoolState extends State<School> {
  List<Map<String, dynamic>> layouts = [
    {
      "label": '攻击',
      "name": "atk",
      "type": 'input',
      "controller": TextEditingController(),
      "value": '2000',
      "ratio": true,
      "num": true,
    },
    {
      "label": '倍率',
      "name": "mgf",
      "type": 'input',
      "controller": TextEditingController(),
      "value": '60',
      "ratio": true,
      "num": true,
    },
    {
      "label": '爆伤',
      "name": "ctDamage",
      "type": 'input',
      "controller": TextEditingController(),
      "value": '100',
      "ratio": true,
      "num": true,
    },
    {
      "label": '增伤',
      "name": "damage",
      "type": 'input',
      "controller": TextEditingController(),
      "value": '0',
      "ratio": true,
      "num": true,
    },
    {
      "label": '减抗加成',
      "name": "resitiance",
      "type": 'input',
      "controller": TextEditingController(),
      "value": '0',
      "ratio": true,
      "num": true,
    },
    {
      "label": '自己',
      "name": "self",
      "type": 'input',
      "controller": TextEditingController(),
      "value": '70',
      "ratio": false,
      "num": true,
    },
    {
      "label": '目标',
      "name": "target",
      "type": 'input',
      "controller": TextEditingController(),
      "value": '70',
      "ratio": false,
      "num": true,
    },
    {
      "label": '减防加成',
      "name": "num",
      "type": 'input',
      "controller": TextEditingController(),
      "value": '0',
      "ratio": true,
      "num": true,
    },
    {
      "label": '易伤加成',
      "name": "vulnerability",
      "type": 'input',
      "controller": TextEditingController(),
      "value": '0',
      "ratio": true,
      "num": true,
    },
    {
      "label": '结果',
      "name": "result",
      "type": 'result',
      "controller": null,
      "value": '0',
    },
    {
      "label": '对比结果',
      "name": "diffRes",
      "type": 'diffRes',
      "controller": null,
      "value": const Text('无'),
    },
    {
      "label": '比较',
      "name": "diffBtn",
      "type": 'btn',
      "controller": null,
      "value": '0',
    },
  ];

  late SchoolSnapshot schoolSnapshot;

  ///佈局數據
  Layout ly = Layout(dataList: [], col: 2);

  ///設置一行顯示多少
  void setCol(int col) {
    Layout lay = Layout(col: col, dataList: layouts);
    if (mounted) {
      setState(() {
        ly = lay;
      });
    }
  }

  ///拖動窗口寬度觸發
  void _changeLayoutWidth(double width) {
    if (width < LayoutConfig.getComputLayoutWidth11()) {
      return setCol(1);
    }
    if (width < LayoutConfig.getComputLayoutWidth12()) {
      return setCol(2);
    }
    if (width < LayoutConfig.getComputLayoutWidth13()) {
      return setCol(3);
    }
    if (width < LayoutConfig.getComputLayoutWidth14()) {
      return setCol(4);
    }
    return setCol(6);
  }

  @override
  void initState() {
    for (var el in layouts) {
      if (el['controller'] != null) {
        el['controller'].text = el['value'];
      }
    }
    compute();
    _changeLayoutWidth(schoolState.layoutWidth);
    schoolState.addListener(() {
      _changeLayoutWidth(schoolState.layoutWidth);
    });

    schoolSnapshot = SchoolSnapshot();
    super.initState();
  }

  ///計算比例
  static double ratio({required val1, required val2}) {
    val1 = Util.toDouble(val1);
    val2 = Util.toDouble(val2);
    return ((val1 / val2) - 1) * 100;
  }

  /// 計算
  void compute() {
    late double attck;
    late double mgf;
    late double ctDamage;
    late double damage;
    late double resitiance;
    late double self;
    late double target;
    late double num;
    late double vulnerability;

    late double diffBtn;

    double getValue({required String name}) {
      try {
        return double.parse(
            layouts.firstWhere((element) => element['name'] == name)['value']);
      } catch (e) {
        return 0.0;
      }
    }

    attck = getValue(name: 'atk');
    damage = getValue(name: 'damage') / 100 + 1;
    ctDamage = getValue(name: 'ctDamage') / 100 + 1;
    vulnerability = getValue(name: 'vulnerability') / 100 + 1;
    mgf = getValue(name: 'mgf') / 100;
    resitiance = (getValue(name: 'resitiance') / -100 - 0.8).abs();
    self = getValue(name: 'self');
    target = getValue(name: 'target');
    num = (getValue(name: 'num') / 100 - 1).abs();
    diffBtn = getValue(name: 'diffBtn');

    //防御
    double fy =
        (self * 10 + 200) / ((self * 10 + 200) + (target * 10 + 200) * num);
    //最终结果
    double result =
        attck * damage * vulnerability * mgf * resitiance * ctDamage * fy;

    setState(() {
      if (diffBtn != 0.0) {
        late Widget wid;
        double diffRes = ((result / diffBtn) - 1) * 100;
        wid = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " $diffBtn->${result.toStringAsFixed(2)}",
            ),
            Text(
              '${diffRes > 0 ? "+" : "-"}${(diffRes > 0 ? diffRes : (((diffBtn / result) - 1) * 100)).toStringAsFixed(2)}%',
              style: TextStyle(
                  color: diffRes > 0
                      ? const Color.fromARGB(255, 14, 248, 34)
                      : const Color.fromARGB(255, 248, 23, 23)),
            )
          ],
        );
        getFieldByName(name: 'diffRes')['value'] = wid;
      }
      getFieldByName(name: 'result')['value'] = result.toStringAsFixed(2);
    });
  }

  ///更顯字段
  void updateField(
      {required String name, required TextEditingController controoller}) {
    var current = layouts.firstWhere((element) => element['name'] == name);
    current['value'] = controoller.text;
    compute();
  }

  ///通過name獲取一個字段
  Map<String, dynamic> getFieldByName({required String name}) {
    return layouts.firstWhere((element) => element['name'] == name);
  }

  final Color COLOR_UP = const Color.fromARGB(255, 14, 248, 34);
  final Color COLOR_DOWN = const Color.fromARGB(255, 248, 23, 23);

  @override
  Widget build(context) {
    return Container(
      color: const Color.fromARGB(170, 240, 240, 240),
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Card(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ...ly.layoutList.map((arr) {
                    List<Widget> coms = arr.map((e) {
                      late Widget com;
                      switch (e['type']) {
                        case 'input':
                          Widget label = Text(e['label']);
                          if (schoolSnapshot.active) {
                            var snapshot =
                                schoolSnapshot.getFieldByName(name: e['name']);
                            if (e['value'] != snapshot['value']) {
                              double res = ratio(
                                  val1: e['value'], val2: snapshot['value']);

                              // 展示比例的计算
                              var ratioNum = (res > 0
                                  ? res.toStringAsFixed(2)
                                  : ratio(
                                          val1: snapshot['value'],
                                          val2: e['value'])
                                      .toStringAsFixed(2));

                              // 是否展示比例
                              bool isShowRatio = e['ratio'] &&
                                  ratioNum != "NaN" &&
                                  ratioNum != 'Infinity';

                              // 展示增减数值的计算
                              var numnum = Util.toDouble(e['value']) -
                                  Util.toDouble(snapshot['value']);
                              bool isShowNum = e['num'];
                              label = Row(
                                children: [
                                  Text(
                                      "${e['label']}  ${Util.toDouble(snapshot['value'])} => ${Util.toDouble(e['value'])}  "),
                                  isShowRatio
                                      ? Text(
                                          "${res > 0 ? 'up' : 'dn'} $ratioNum% ",
                                          style: TextStyle(
                                            fontSize: 14,
                                            // 如果对比的是target则翻转颜色
                                            color: (e['name'] != 'target'
                                                    ? res > 0
                                                    : res < 0)
                                                ? COLOR_UP
                                                : COLOR_DOWN,
                                          ),
                                        )
                                      : const Text(''),
                                  isShowNum
                                      ? Text(
                                          "${numnum > 0 ? '+' : ''}${numnum.toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            // 如果对比的是target则翻转颜色
                                            color: (e['name'] != 'target'
                                                    ? numnum > 0
                                                    : numnum < 0)
                                                ? COLOR_UP
                                                : COLOR_DOWN,
                                          ),
                                        )
                                      : const Text(''),
                                ],
                              );
                            }
                          }

                          com = TextField(
                            controller: e['controller'],
                            decoration: InputDecoration(label: label),
                            onChanged: (val) => updateField(
                                name: e['name'], controoller: e['controller']),
                          );
                          break;
                        case 'result':
                          com = Text("結果:${e['value']}");
                          break;
                        case 'diffRes':
                          com = e['value'];
                          break;
                        case 'btn':
                          com = IconButton(
                            onPressed: () {
                              setState(() {
                                late double res;
                                try {
                                  res = double.parse(
                                      getFieldByName(name: 'result')['value']);
                                } catch (e) {
                                  res = 0.0;
                                }
                                // 将重要信息存入快照
                                schoolSnapshot.data = layouts
                                    .sublist(0, 9)
                                    .map((layou) => {
                                          "name": layou['name'],
                                          "value": layou['value'],
                                          "ratio": layou['ratio'],
                                          "num": layou['num'],
                                        })
                                    .toList();
                                // 修改对比状态
                                schoolSnapshot.active = true;

                                // 结果对比
                                setState(() {
                                  getFieldByName(name: 'diffRes')['value'] =
                                      const Text('已保存当前结果');
                                  getFieldByName(name: 'diffBtn')['value'] =
                                      '$res';
                                });
                              });
                            },
                            icon: const Icon(Icons.accessible_forward_outlined),
                          );
                          break;

                        default:
                          com = Text(e['value']);
                          break;
                      }
                      return Expanded(
                        flex: 1,
                        child: com,
                      );
                    }).toList();

                    return Row(
                      children: coms,
                    );
                  }).toList()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Layout {
  Layout({required List<Map<String, dynamic>> dataList, required int col}) {
    List<Map<String, dynamic>> arr = [];
    for (var data in dataList) {
      if (col <= arr.length) {
        if (arr.isNotEmpty) {
          layoutList.add(arr);
        }
        arr = [data];
      } else {
        arr.add(data);
      }
    }
    layoutList.add(arr);
  }
  List<List<Map<String, dynamic>>> layoutList = [];
}
