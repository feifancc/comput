import 'package:flutter/material.dart';

class LayoutInput extends StatelessWidget {
  final Function(String val) setValue;
  final Function() getValue;
  final String label;
  final String? helpText;
  final TextEditingController controller;
  const LayoutInput({
    super.key,
    required this.setValue,
    required this.getValue,
    required this.label,
    required this.controller,
    this.helpText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text(label),
        hintText: helpText,
        border: InputBorder.none,
      ),
      controller: controller,
      onChanged: (val) {
        setValue(val);
      },
    );
  }
}
