import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  static int id = 1;
  static var getId = () => id++;

  addField({required int index}) {
    TextEditingController contr = TextEditingController();
    contr.text = '';
    int id = getId();
    int percentage = 0;

    return {
      "controller": contr,
      "id": id,
      "index": index,
      "percentage": percentage,
      "selValue": 0
    };
  }

  getFeildById(int id) {
    Map<String, dynamic> field = {};
    for (var current in fields) {
      if (current['id'] == id) {
        current = current;
      }
    }
    return field;
  }

  void deleteField(int id) {
    setState(() {
      fields = fields.where((e) => e["id"] != id).toList();
    });
    updateFieldsPercentage();
  }

  @override
  void initState() {
    super.initState();
    for (int i = 1; i < count + 1; i++) {
      fields.add(addField(index: i));
    }
  }

  updateFieldsPercentage() {
    setState(() {
      Map<dynamic, Map<String, dynamic>> map = {};
      double count = 0;
      for (var e in fields) {
        double value = 0;
        try {
          value = double.parse(e['controller'].text);
        } catch (e) {
          e;
        }
        count += value;
        map[e['id']] = {"value": value};
      }
      map.forEach((key, value) {
        for (var field in fields) {
          if (field['id'] == key) {
            field['percentage'] = value['value'] / count * 100;
          }
        }
      });
      fields = fields;
    });
  }

  int count = 4;

  List<Map<String, dynamic>> fields = [];

  @override
  Widget build(context) {
    var items = SelectItem.getItems().map((e) {
      return DropdownMenuItem(
        value: e['value'] as int,
        child: Text(e['label'] as String),
      );
    }).toList();
    return Container(
      color: const Color.fromARGB(170, 240, 240, 240),
      child: ListView(
        children: [
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              ...fields.map<Container>((e) {
                int id = e['id'];
                return Container(
                  alignment: Alignment.topCenter,
                  constraints:
                      const BoxConstraints(maxWidth: 400, minWidth: 200),
                  child: Card(
                    margin: const EdgeInsetsDirectional.only(
                      start: 6,
                      top: 6,
                      end: 6,
                      bottom: 6,
                    ),
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 20,
                                child: DropdownButton(
                                  items: items,
                                  hint: const Text("命途"),
                                  isExpanded: true,
                                  value: SelectItem.getSelectValue(
                                      e['controller'].text),
                                  onChanged: (int? value) {
                                    TextEditingController contr =
                                        e['controller'];
                                    contr.text = value.toString();
                                    updateFieldsPercentage();
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 70,
                                child: TextField(
                                    onChanged: (e) => updateFieldsPercentage(),
                                    controller: e['controller'],
                                    decoration: InputDecoration(
                                      label: Text('第${e['index']}位'),
                                    ),
                                    keyboardType: TextInputType.number),
                              ),
                              Expanded(
                                  flex: 10,
                                  child: IconButton(
                                    onPressed: () => deleteField(id),
                                    color: const Color.fromARGB(255, 255, 0, 0),
                                    icon: const Icon(Icons.highlight_remove),
                                  ))
                            ],
                          ),
                          Text(e["percentage"] == 0
                              ? ''
                              : '受击概率占比:${e["percentage"].toStringAsFixed(2)}')
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  int max = 0;
                  for (var e in fields) {
                    if (e['index'] > max) {
                      max = e['index'];
                    }
                  }
                  fields.add(addField(index: max + 1));
                });
              },
              child: const Text(
                '新增+',
              ))
        ],
      ),
    );
  }
}

class SelectItem {
  static const List<Map<String, dynamic>> items = [
    {"label": "童鞋", "value": 100},
    {"label": "虚无", "value": 100},
    {"label": "丰饶", "value": 100},
    {"label": "毁灭", "value": 125},
    {"label": "存户", "value": 150},
    {"label": "芝士", "value": 75},
    {"label": "巡猎", "value": 75},
  ];
  static List<Map<String, dynamic>> getItems() {
    List<Map<String, dynamic>> classify = [];
    for (var item in items) {
      bool isExist = false;
      for (var d in classify) {
        if (d['value'] == item['value']) {
          isExist = true;
          d['label'].add(item['label']);
        }
      }
      if (!isExist) {
        classify.add({
          "label": [item['label']],
          "value": item['value']
        });
      }
    }
    classify = classify
        .map((e) => ({"label": e['label'].join(','), "value": e['value']}))
        .toList();
    return classify;
  }

  static int? getSelectValue(String val) {
    try {
      int value = int.parse(val);
      if (items.any((element) => element['value'] == value)) {
        return value;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
