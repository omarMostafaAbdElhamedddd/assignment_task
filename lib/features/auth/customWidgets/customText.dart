import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.underline = TextDecoration.none,
    this.height = 1.4,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.fontSize = 16,
    required this.text,
    this.onTap,
    this.fontFimaly,
    this.letterSpace,
  });

  final Color color;

  final String text;
  final String? fontFimaly;
  final Function()? onTap;
  final double height;
  final FontWeight fontWeight;
  final double? letterSpace;

  final double fontSize;
  final TextAlign textAlign;
  final int maxLines;
  final TextDecoration underline;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: TextStyle(
          letterSpacing: letterSpace,
          decoration: underline,
          fontFamily: fontFimaly,
          color: color,
          fontWeight: fontWeight,
          height: height,
          fontSize: fontSize,
        ),
      ),
    );
  }
}