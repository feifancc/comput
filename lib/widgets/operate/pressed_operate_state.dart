import 'package:flutter/material.dart';

class PressedOperateState {
  static int _id = 1;
  static get id => _id++;

  PressedOperateState({this.label, this.text, this.methodPressed}) {
    cid = id;
  }
  void Function(PressedOperateState state)? methodPressed;
  late int cid;
  String? label;
  Text? text;

  toMap() => {
        'cid': cid,
        'label': label,
        'text': text,
      };
}


