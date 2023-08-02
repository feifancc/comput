import 'package:flutter/material.dart';

class LayoutConfig {
  /// 横向菜单展开切换灵界点
  static int _vhPoint = 750;
  static int getVhPoint() => _vhPoint;
  static setVhPoint(String value) {
    RegExp reg = RegExp('^[0-9]{1,4}\$');
    if (reg.hasMatch(value)) {
      _vhPoint = int.parse(value);
    }
  }

  /// 横向菜单展开切换灵界点
  static int _criticalPoint = 900;
  static int getCriticalPoint() => _criticalPoint;
  static setCriticalPoint(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _criticalPoint = int.parse(value);
    }
  }

  /// 横向菜单名称显示距离
  static double _minExtendedWidth = 150;
  static getMinExtendeWidth() => _minExtendedWidth;
  static setMinExtendeWidth(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _minExtendedWidth = double.parse(value);
    }
  }

  /// 计算页面1/1宽度距离
  static double _computLayoutWidth11 = 600;
  static getComputLayoutWidth11() => _computLayoutWidth11;
  static setComputLayoutWidth11(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _computLayoutWidth11 = double.parse(value);
    }
  }

  /// 计算页面1/2宽度距离
  static double _computLayoutWidth12 = 1100;
  static getComputLayoutWidth12() => _computLayoutWidth12;
  static setComputLayoutWidth12(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _computLayoutWidth12 = double.parse(value);
    }
  }

  /// 计算页面1/3宽度距离
  static double _computLayoutWidth13 = 1500;
  static getComputLayoutWidth13() => _computLayoutWidth13;
  static setComputLayoutWidth13(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _computLayoutWidth13 = double.parse(value);
    }
  }

  /// 计算页面1/4宽度距离
  static double _computLayoutWidth14 = 1800;
  static getComputLayoutWidth14() => _computLayoutWidth14;
  static setComputLayoutWidth14(String value) {
    RegExp reg = RegExp('^[0-9]{1,3}\$');
    if (reg.hasMatch(value)) {
      _computLayoutWidth14 = double.parse(value);
    }
  }

  /// Card颜色
  static Color _cardColor = const Color(0xffffff00);
  static Color getCardColor() => _cardColor;
  static setCardColor(Color value) => _cardColor = value;
}
