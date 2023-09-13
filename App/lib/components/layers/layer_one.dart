import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LayerOne extends StatelessWidget {
  const LayerOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: context.getWidth,
          height: context.getHeight,
          decoration: BoxDecoration(
            color: ETheme.colors.white.withOpacity(0.4),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60.0),
                bottomRight: Radius.circular(60.0)),
          ),
        ),
      ],
    );
  }
}
