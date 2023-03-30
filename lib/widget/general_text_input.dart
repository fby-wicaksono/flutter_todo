import 'package:flutter/material.dart';
import 'package:flutter_todo/widget/general_input_label.dart';

class GeneralTextInput extends StatelessWidget {
  const GeneralTextInput({
    super.key,
    this.label,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.labelStyle,
    this.inputStyle,
    this.textInputType,
    this.controller,
    this.isReadOnly = false,
  });

  final String? label;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final TextStyle? labelStyle;
  final TextStyle? inputStyle;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final bool isReadOnly;

  TextInputType get _getTextInputType {
    if (textInputType != null) {
      return textInputType!;
    }

    return maxLines > 1 ? TextInputType.multiline : TextInputType.text;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          GeneralInputLabel(
            label: label!,
            labelStyle: labelStyle,
          ),
        const SizedBox(height: 4.0),
        TextField(
          maxLength: maxLength,
          readOnly: isReadOnly,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: _getTextInputType,
          controller: controller,
          style: inputStyle ??
              textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ],
    );
  }
}