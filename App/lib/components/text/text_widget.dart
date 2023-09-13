import 'package:final_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
      required this.text,
      this.size = 14,
      this.isBold = false,
      this.color = primary2, //TODO : have to change it
      this.lineThrough = false,
      this.overflow,
      this.textAlign,
      this.fontStyle,
      this.fontFamily = 'prata'});
  final String text;
  final double size;
  final bool isBold;
  final bool lineThrough;
  final Color color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final String? fontFamily;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        fontStyle: fontStyle ?? FontStyle.normal,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
        decoration: lineThrough ? TextDecoration.lineThrough : null,
      ),
    );
  }
}
