import 'package:comput/widgets/operate/pressed_operate_state.dart';
import 'package:flutter/material.dart';

class PressedOperate {
  PressedOperate(PressedOperateState _state, {required this.onPressed}) {
    _state.text = _state.text ??
        Text(
          _state.label!,
          style: const TextStyle(color: Color(0xffffffff)),
        );
    state = _state;
    com = TextButton(
      onPressed: () => onPressed(state),
      child: _state.text!,
    );
  }

  void Function(PressedOperateState state) onPressed;
  late PressedOperateState state;
  late Widget com;
}
