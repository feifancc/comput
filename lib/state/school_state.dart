// ignore_for_file: constant_identifier_names

import 'package:comput/util/layot_config.dart';
import 'package:flutter/material.dart';

class SchoolState extends ChangeNotifier {
  static const int HORIZONTAL = 1;
  static const int VERTICAL = 0;

  late int direction = 0;
  late double layoutWidth;

  void setLayoutWidth({required double width}) {
    layoutWidth = width;
    if (width <= LayoutConfig.getVhPoint()) {
      direction = VERTICAL;
      notifyListeners();
    }
    if (width > LayoutConfig.getVhPoint()) {
      direction = HORIZONTAL;
      notifyListeners();
    }
  }
}

class SchoolSnapshot {
  bool active = false;
  List<Map<String, dynamic>> data = [];

  ///通過name獲取一個字段
  Map<String, dynamic> getFieldByName({required String name}) {
    return data.firstWhere((element) => element['name'] == name);
  }
}

var schoolState = SchoolState();
