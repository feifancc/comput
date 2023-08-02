import 'package:comput/page/setting/xxx/all.dart';
import 'package:flutter/material.dart';

class RowLayout extends StatelessWidget {
  RowLayout({
    super.key,
    required this.pathChild,
    required this.scaffoldKey,
  });

  final Map<String, dynamic> pathChild;
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> children = List.of(pathChild['children']);
    int index = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pathChild['title'],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          children: children.map((child) {
            switch (child['type']) {
              case "input":
                return Container(
                  width: 300,
                  margin: const EdgeInsets.only(left: 20),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: LayoutInput(
                        label: "${++index}.${child['label']}",
                        getValue: child['getValue'],
                        setValue: child['setValue'],
                        helpText: child['helpText']),
                  ),
                );
              case "color":
                return Container(
                  width: 300,
                  margin: const EdgeInsets.only(left: 20),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTapUp: (d) {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      child: LayoutColor(
                          label: "${++index}.${child['label']}",
                          getValue: child['getValue'],
                          setValue: child['setValue'],
                          helpText: child['helpText']),
                    ),
                  ),
                );

              default:
                return const Text('null');
            }
          }).toList(),
        )
      ],
    );
  }
}
