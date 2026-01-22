import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  final Color? lineColor;
  final Color? textColor;
  final double? fontSize;
  final double? thickness;
  final double? spacing;
  final bool? square;

  const DividerWithText({
    super.key,
    required this.text,
    this.lineColor,
    this.textColor,
    this.fontSize = 14,
    this.thickness = 1,
    this.spacing = 10,
    this.square = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: lineColor ?? Theme.of(context).dividerColor,
            thickness: thickness,
            endIndent: spacing,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor ?? Theme.of(context).textTheme.titleSmall?.color,
            fontSize: fontSize,
          ),
        ),
        Expanded(
          child: Divider(
            color: lineColor ?? Theme.of(context).dividerColor,
            thickness: thickness,
            indent: spacing,
          ),
        ),
      ],
    );
  }
}
