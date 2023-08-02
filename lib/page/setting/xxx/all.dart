// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LayoutInput extends StatelessWidget {
  final Function(String val) setValue;
  final Function() getValue;
  final String label;
  final String? helpText;
  LayoutInput({
    super.key,
    required this.setValue,
    required this.getValue,
    required this.label,
    this.helpText,
  });

  TextEditingController contr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    contr.text = "${getValue()}";

    return TextField(
      decoration: InputDecoration(
        label: Text(label),
        hintText: helpText,
        border: InputBorder.none,
      ),
      controller: contr,
      onChanged: setValue,
    );
  }
}

class LayoutColor extends StatelessWidget {
  final Function(Color val) setValue;
  final Color Function() getValue;
  final String label;
  final String? helpText;
  const LayoutColor({
    super.key,
    required this.setValue,
    required this.getValue,
    required this.label,
    this.helpText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(
          height: 50,
          width: 50,
          child: ClipOval(
              child: Container(
            color: getValue(),
          )),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(5.0),
          //   color: getValue(),
          // ),
        ),
      ],
    );
  }
}
