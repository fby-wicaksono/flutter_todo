import 'package:flutter/material.dart';
import 'package:flutter_todo/widget/general_input_label.dart';

class LabelWithValue extends StatelessWidget {
  const LabelWithValue({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralInputLabel(
          label: label,
          labelStyle: textTheme.labelLarge?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          value,
          style: textTheme.titleMedium,
        ),
      ],
    );
  }
}