import 'package:comput/page/setting/xxx/layout_color.dart';
import 'package:comput/page/setting/xxx/layout_input.dart';
import 'package:flutter/material.dart';

class RowLayout extends StatelessWidget {
  const RowLayout({
    super.key,
    required this.pathChild,
    required this.scaffoldKey,
    required this.setColor,
  });

  final Map<String, dynamic> pathChild;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final void Function(Color c, void Function(Color cl)) setColor;

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
            final double width = pathChild['width'] != null
                ? pathChild['width'].toDouble()
                : 150;
            switch (child['type']) {
              case "input":
                return Container(
                  width: width,
                  margin: const EdgeInsets.only(left: 20),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: LayoutInput(
                      label: "${++index}.${child['label']}",
                      getValue: child['getValue'],
                      setValue: child['setValue'],
                      helpText: child['helpText'],
                      controller: child['controller'],
                    ),
                  ),
                );
              case "color":
                return Container(
                  width: width,
                  margin: const EdgeInsets.only(left: 20),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTapUp: (d) {
                        scaffoldKey.currentState?.openDrawer();
                        setColor(child['getValue'](), child['setValue']);
                      },
                      child: LayoutColor(
                        label: "${++index}.${child['label']}",
                        getValue: child['getValue'],
                        setValue: child['setValue'],
                        helpText: child['helpText'],
                      ),
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
