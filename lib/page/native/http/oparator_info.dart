import 'package:flutter/material.dart';

class OparatorInfo {
  OparatorInfo({required this.icon, required this.label, this.onPressed});

  final IconData icon;
  final String label;
  void Function()? onPressed;

  factory OparatorInfo.fromJson(Map<String, dynamic> map) =>
      OparatorInfo(icon: map['icon'], label: map['label']);
}
