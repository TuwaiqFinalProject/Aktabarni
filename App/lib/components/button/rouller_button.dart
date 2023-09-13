import 'package:final_project/components/text/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RollerButton extends StatelessWidget {
  final String title;
  final bool switchValue;
  final ValueChanged<bool>? onChanged;

  const RollerButton({
    Key? key,
    required this.title,
    required this.switchValue,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: title,
          color: Colors.grey,
          isBold: true,
        ),
        Transform.scale(
          scale: 0.8,
          child: CupertinoSwitch(
            value: switchValue,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}