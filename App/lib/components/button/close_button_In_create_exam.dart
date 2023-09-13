import 'package:final_project/screens/navigation_bar_screen.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:flutter/material.dart';

class CloseButtonInCreateExam extends StatelessWidget {
  const CloseButtonInCreateExam({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(25.0),
        child: InkWell(
          onTap: () {
            context.pushNav(screen: const NavigationBarScreen());
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ETheme.colors.primary.withOpacity(.15),
            ),
            child: Icon(
              Icons.close,
              color: ETheme.colors.primary,
            ),
          ),
        ));
  }
}
