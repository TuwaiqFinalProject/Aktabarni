import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.child, this.width, this.height});
  final Widget child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width ?? context.getWidth - 30,
          height: height ?? context.getHeight - 95,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        BlurryContainer(
          blur: 4,
          child: Container(
            width: context.getWidth - 50,
            height: context.getHeight - 50,
            color: Colors.transparent,
            child: child,
          ),
        )
      ],
    );
  }
}
