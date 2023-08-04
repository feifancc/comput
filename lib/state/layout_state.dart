import 'package:flutter/material.dart';
import 'dart:async';

class LayoutConfigState extends ChangeNotifier {
  static const int HORIZONTAL = 1;
  static const int VERTICAL = 0;

  int direction = 0;
  late double layoutWidth;

  void setLayoutWidth({required double width}) {
    layoutWidth = width;
    if (width <= getVhPoint()) {
      direction = VERTICAL;
      Timer(Duration(milliseconds: 300), () {
        notifyListeners();
      });
    }
    if (width > getVhPoint()) {
      direction = HORIZONTAL;
      Timer(Duration(milliseconds: 300), () {
        notifyListeners();
      });
    }
  }

  /// 设置页面菜单
  List<Map<String, dynamic>> getPath() => [
        {
          "title": '布局',
          'children': [
            {
              "label": "横向/纵向切换布局临界点",
              "type": 'input',
              "controller": TextEditingController(text: '${getVhPoint()}'),
              "getValue": getVhPoint,
              "setValue": setVhPoint,
              "helpText": "整数,像素,默认750"
            },
            {
              "label": "展开菜单临界点",
              "type": 'input',
              "controller":
                  TextEditingController(text: '${getCriticalPoint()}'),
              "getValue": getCriticalPoint,
              "setValue": setCriticalPoint,
              "helpText": "整数,像素,默认900"
            },
            {
              "label": "菜单宽度",
              "type": 'input',
              "controller":
                  TextEditingController(text: '${getMinExtendeWidth()}'),
              "getValue": getMinExtendeWidth,
              "setValue": setMinExtendeWidth,
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
              "controller":
                  TextEditingController(text: '${getComputLayoutWidth11()}'),
              "getValue": getComputLayoutWidth11,
              "setValue": setComputLayoutWidth11,
              "helpText": "浮点数,像素,默认600"
            },
            {
              "label": "设置1/2布局",
              "type": 'input',
              "controller":
                  TextEditingController(text: '${getComputLayoutWidth12()}'),
              "getValue": getComputLayoutWidth12,
              "setValue": setComputLayoutWidth12,
              "helpText": "浮点数,像素,默认1100"
            },
            {
              "label": "设置1/3布局",
              "type": 'input',
              "controller":
                  TextEditingController(text: '${getComputLayoutWidth13()}'),
              "getValue": getComputLayoutWidth13,
              "setValue": setComputLayoutWidth13,
              "helpText": "浮点数,像素,默认1500"
            },
            {
              "label": "设置1/4布局",
              "type": 'input',
              "controller":
                  TextEditingController(text: '${getComputLayoutWidth14()}'),
              "getValue": getComputLayoutWidth14,
              "setValue": setComputLayoutWidth14,
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
              'getValue': getCardColor,
              'setValue': setCardColor
            },
            {
              'label': 'Prime',
              'type': "color",
              'getValue': getPrimeColor,
              'setValue': setPrimeColor
            },
            {
              'label': 'disabled',
              'type': "color",
              'getValue': getDisabledColor,
              'setValue': setDisabledColor,
            },
            {
              'label': 'splash',
              'type': "color",
              'getValue': getSplashColor,
              'setValue': setSplashColor
            },
          ]
        }
      ];

  /// 横向菜单展开切换灵界点
  int _vhPoint = 750;
  int getVhPoint() => _vhPoint;
  setVhPoint(String value) {
    RegExp reg = RegExp('^[0-9]{1,4}\$');
    if (reg.hasMatch(value)) {
      _vhPoint = int.parse(value);
      notifyListeners();
    }
  }

  /// 横向菜单展开切换灵界点
  int _criticalPoint = 900;
  int getCriticalPoint() => _criticalPoint;
  setCriticalPoint(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _criticalPoint = int.parse(value);
      notifyListeners();
    }
  }

  /// 横向菜单名称显示距离
  double _minExtendedWidth = 150;
  getMinExtendeWidth() => _minExtendedWidth;
  setMinExtendeWidth(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _minExtendedWidth = double.parse(value);
      notifyListeners();
    }
  }

  /// 计算页面1/1宽度距离
  double _computLayoutWidth11 = 600;
  getComputLayoutWidth11() => _computLayoutWidth11;
  setComputLayoutWidth11(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _computLayoutWidth11 = double.parse(value);
      notifyListeners();
    }
  }

  /// 计算页面1/2宽度距离
  double _computLayoutWidth12 = 1100;
  getComputLayoutWidth12() => _computLayoutWidth12;
  setComputLayoutWidth12(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _computLayoutWidth12 = double.parse(value);
      notifyListeners();
    }
  }

  /// 计算页面1/3宽度距离
  double _computLayoutWidth13 = 1500;
  getComputLayoutWidth13() => _computLayoutWidth13;
  setComputLayoutWidth13(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _computLayoutWidth13 = double.parse(value);
      notifyListeners();
    }
  }

  /// 计算页面1/4宽度距离
  double _computLayoutWidth14 = 1800;
  getComputLayoutWidth14() => _computLayoutWidth14;
  setComputLayoutWidth14(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _computLayoutWidth14 = double.parse(value);
      notifyListeners();
    }
  }

  /// Card颜色
  Color _cardColor = const Color(0xffffff00);
  Color getCardColor() => _cardColor;
  setCardColor(Color value) {
    _cardColor = value;
    notifyListeners();
  }

  /// 主要颜色
  Color _primeColor = const Color.fromARGB(255, 255, 252, 254);
  Color getPrimeColor() => _primeColor;
  void setPrimeColor(Color value) {
    _primeColor = value;
    notifyListeners();
  }

  /// 禁用顏色
  Color _disabledColor = const Color.fromARGB(255, 151, 151, 151);
  Color getDisabledColor() => _disabledColor;
  setDisabledColor(Color value) {
    _disabledColor = value;
    notifyListeners();
  }

  /// 濺射顏色
  Color _splashColor = const Color.fromARGB(186, 81, 168, 250);
  Color getSplashColor() => _splashColor;
  setSplashColor(Color value) {
    _splashColor = value;
    notifyListeners();
  }
}
