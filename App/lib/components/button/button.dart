import 'package:final_project/components/text/text_widget.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    this.onPress,
    this.textSize = 20,
    this.borderRadius = 15,
    this.isBold = false,
    this.color = Colors.black,
    required this.backgroundColor,
    this.btnHigth,
    this.btnWidth,
    this.fontFamily,
  });
  final String text;
  final bool isBold;
  final double textSize;
  final double borderRadius;
  final Function()? onPress;
  final Color color;
  final Color backgroundColor;
  final double? btnHigth;
  final double? btnWidth;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: Size(btnWidth ?? 100, btnHigth ?? 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextWidget(
          fontFamily: fontFamily,
          text: text,
          textAlign: TextAlign.center,
          size: textSize,
          isBold: isBold,
          color: color,
        ),
      ),
    );
  }
}
