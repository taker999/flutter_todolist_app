import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget(
    this.text, {
    super.key,
    this.fontWeight,
    this.fontSize,
    this.color,
    this.maxLines,
    this.decoration,
  });

  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final int? maxLines;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        overflow: TextOverflow.ellipsis,
        decoration: decoration,
      ),
    );
  }
}
