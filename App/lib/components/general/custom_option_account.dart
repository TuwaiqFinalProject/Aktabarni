import 'package:final_project/components/text/text_widget.dart';
import 'package:flutter/material.dart';

class Rowbuild extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  const Rowbuild({
    Key? key,
    required this.title,
    required this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('data'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: title,
              color: color,
              isBold: true,
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}