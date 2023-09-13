import 'package:final_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckboxWidget extends StatelessWidget {
  CheckboxWidget({super.key, required this.data, this.onTap, this.color});

  final String data;
  Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        // height: 200,
        // width: 200,
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: color ?? ETheme.colors.white,
                  border: Border.all(color: ETheme.colors.primary),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    data,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
