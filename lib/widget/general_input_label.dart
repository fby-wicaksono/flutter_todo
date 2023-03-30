import 'package:flutter/material.dart';

class GeneralInputLabel extends StatelessWidget {
  const GeneralInputLabel({
    Key? key,
    required this.label,
    this.labelStyle,
  }) : super(key: key);

  final String label;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      label,
      style: labelStyle ?? textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
    );
  }
}