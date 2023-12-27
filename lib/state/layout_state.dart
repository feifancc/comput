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
      Timer(const Duration(milliseconds: 300), () {
        notifyListeners();
      });
    }
    if (width > getVhPoint()) {
      direction = HORIZONTAL;
      Timer(const Duration(milliseconds: 300), () {
        notifyListeners();
      });
    }
  }

  /// 设置页面菜单
  List<Map<String, dynamic>> getPath() => [
        {
          "title": '布局',
          'width': 300,
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
          'width': 150,
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
          'title': "主题颜色",
          'width': 100,
          "children": [
            {
              'label': '卡片',
              'type': "color",
              'getValue': getCardColor,
              'setValue': setCardColor
            },
            {
              'label': '主要',
              'type': "color",
              'getValue': getPrimeColor,
              'setValue': setPrimeColor
            },
            {
              'label': '禁用',
              'type': "color",
              'getValue': getDisabledColor,
              'setValue': setDisabledColor,
            },
            {
              'label': '溅射',
              'type': "color",
              'getValue': getSplashColor,
              'setValue': setSplashColor
            },
          ]
        },
        {
          'title': "颜色选择器设置",
          'width': 150,
          "children": [
            {
              'label': '选中颜色',
              'type': "color",
              'getValue': getColorSelectorSelerctdColor,
              'setValue': setColorSelectorSelerctdColor
            },
            {
              'label': '线条宽度',
              'type': "input",
              "helpText": "浮点数,默认2",
              "controller": TextEditingController(
                  text: '${getColorSelectorMainLineWidth()}'),
              'getValue': getColorSelectorMainLineWidth,
              'setValue': setColorSelectorMainLineWidth
            },
            {
              'label': '动画圆弧',
              'type': "input",
              "helpText": "浮点数,默认0.5",
              "controller":
                  TextEditingController(text: '${getColorSelectorMainConic()}'),
              'getValue': getColorSelectorMainConic,
              'setValue': setColorSelectorMainConic
            },
            {
              'label': '动画速度',
              'type': "input",
              "helpText": "整数,毫秒,默认500",
              "controller": TextEditingController(
                  text: '${getColorSelectorAnimationSpeed()}'),
              'getValue': getColorSelectorAnimationSpeed,
              'setValue': setColorSelectorAnimationSpeed
            },
          ]
        },
        {
          'title': "网格动画设置",
          'width': 150,
          "children": [
            {
              'label': '线条颜色1',
              'type': "color",
              'getValue': getGridAnimationLineColorOne,
              'setValue': setGridAnimationLineColorOne,
            },
            {
              'label': '线条颜色2',
              'type': "color",
              'getValue': getGridAnimationLineColorTwo,
              'setValue': setGridAnimationLineColorTwo,
            },
            {
              'label': '线条宽度1',
              'type': "input",
              "helpText": "浮点数,默认1",
              "controller":
                  TextEditingController(text: '${getGridAnimationLineWidth()}'),
              'getValue': getGridAnimationLineWidth,
              'setValue': setGridAnimationLineWidth
            },
            {
              'label': '线条宽度2',
              'type': "input",
              "helpText": "浮点数,默认1",
              "controller": TextEditingController(
                  text: '${getGridAnimationLineWidthTwo()}'),
              'getValue': getGridAnimationLineWidthTwo,
              'setValue': setGridAnimationLineWidthTwo
            },
            {
              'label': '点位大小',
              'type': "input",
              "helpText": "默认5",
              "controller": TextEditingController(
                  text: '${getGridAnimationPointRadius()}'),
              'getValue': getGridAnimationPointRadius,
              'setValue': setGridAnimationPointRadius
            },
          ]
        },
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
      try {
        _computLayoutWidth12 = double.parse(value);
        notifyListeners();
      } catch (e) {
        e;
      }
    }
  }

  /// 计算页面1/3宽度距离
  double _computLayoutWidth13 = 1500;
  getComputLayoutWidth13() => _computLayoutWidth13;
  setComputLayoutWidth13(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      try {
        _computLayoutWidth13 = double.parse(value);
        notifyListeners();
      } catch (e) {
        e;
      }
    }
  }

  /// 计算页面1/4宽度距离
  double _computLayoutWidth14 = 1800;
  getComputLayoutWidth14() => _computLayoutWidth14;
  setComputLayoutWidth14(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      if (reg.hasMatch(value)) {
        try {
          _computLayoutWidth14 = double.parse(value);
          notifyListeners();
        } catch (e) {
          e;
        }
      }
    }
  }

  /// Card颜色
  Color _cardColor = const Color.fromARGB(255, 233, 230, 230);
  Color getCardColor() => _cardColor;
  setCardColor(Color value) {
    _cardColor = value;
    notifyListeners();
  }

  /// 主要颜色
  Color _primeColor = const Color.fromARGB(255, 110, 224, 134);
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

  /// 颜色选择器->主选择器->选中颜色
  Color _colorSelectorSelerctdColor = const Color.fromARGB(255, 250, 205, 4);
  Color getColorSelectorSelerctdColor() => _colorSelectorSelerctdColor;
  setColorSelectorSelerctdColor(Color value) {
    _colorSelectorSelerctdColor = value;
    notifyListeners();
  }

  /// 颜色选择器->主选择器->选中线条宽度
  double _colorSelectorMainLineWidth = 2;
  double getColorSelectorMainLineWidth() => _colorSelectorMainLineWidth;
  setColorSelectorMainLineWidth(String value) {
    RegExp reg = RegExp('^[0-9.]{1,3}\$');
    if (reg.hasMatch(value)) {
      try {
        _colorSelectorMainLineWidth = double.parse(value);
        notifyListeners();
      } catch (e) {
        e;
      }
    }
  }

  /// 颜色选择器->主选择器->选中动画线条圆弧值
  double _colorSelectorMainConic = 0.5;
  double getColorSelectorMainConic() => _colorSelectorMainConic;
  setColorSelectorMainConic(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _colorSelectorMainConic = double.parse(value);
      notifyListeners();
    }
  }

  /// 颜色选择器->主选择器->选中动画速度
  int _colorSelectorAnimationSpeed = 500;
  int getColorSelectorAnimationSpeed() => _colorSelectorAnimationSpeed;
  setColorSelectorAnimationSpeed(String value) {
    RegExp reg = RegExp('^[0-9]{1,4}\$');
    if (reg.hasMatch(value)) {
      try {
        _colorSelectorAnimationSpeed = int.parse(value);
        notifyListeners();
      } catch (e) {
        e;
      }
    }
  }

  /// 网格动画->线条->颜色1
  Color _gridAnimationLineColorOne = const Color.fromARGB(255, 62, 199, 28);
  Color getGridAnimationLineColorOne() => _gridAnimationLineColorOne;
  setGridAnimationLineColorOne(Color value) {
    _gridAnimationLineColorOne = value;
    notifyListeners();
  }

  /// 网格动画->线条->颜色2
  Color _gridAnimationLineColorTwo = const Color.fromARGB(255, 216, 110, 110);
  Color getGridAnimationLineColorTwo() => _gridAnimationLineColorTwo;
  setGridAnimationLineColorTwo(Color value) {
    _gridAnimationLineColorTwo = value;
    notifyListeners();
  }

  /// 网格动画->线条->宽度1
  double _gridAnimationLineWidth = 2;
  double getGridAnimationLineWidth() => _gridAnimationLineWidth;
  setGridAnimationLineWidth(String value) {
    RegExp reg = RegExp('^[0-9.]{1,2}\$');
    if (reg.hasMatch(value)) {
      try {
        _gridAnimationLineWidth = double.parse(value);
        notifyListeners();
      } catch (e) {
        e;
      }
    }
  }

  /// 网格动画->线条->宽2
  double _gridAnimationLineWidthTwo = .1;
  double getGridAnimationLineWidthTwo() => _gridAnimationLineWidthTwo;
  setGridAnimationLineWidthTwo(String value) {
    RegExp reg = RegExp('^[0-9.]{1,2}\$');
    if (reg.hasMatch(value)) {
      try {
        _gridAnimationLineWidthTwo = double.parse(value);
        notifyListeners();
      } catch (e) {
        e;
      }
    }
  }

  /// 网格动画->圆点->半径
  double _gridAnimationPointRadius = 3;
  double getGridAnimationPointRadius() => _gridAnimationPointRadius;
  setGridAnimationPointRadius(String value) {
    RegExp reg = RegExp('^[0-9.]{1,2}\$');
    if (reg.hasMatch(value)) {
      try {
        _gridAnimationPointRadius = double.parse(value);
        notifyListeners();
      } catch (e) {
        e;
      }
    }
  }
}
