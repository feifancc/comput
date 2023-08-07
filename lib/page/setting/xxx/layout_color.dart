import 'package:flutter/material.dart';

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
        ClipOval(
          child: Container(
            height: 56,
            width: 56,
            color: Theme.of(context).disabledColor,
            child: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: ClipOval(
                  child: Container(
                    color: getValue(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
