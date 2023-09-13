import 'package:final_project/app.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: AnimatedSplashScreen(
      duration: 500,
      splash: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                color: ETheme.colors.second,
              ),
              kVSpace16,
              TextWidget(
                text: 'Aktabarni',
                size: 30,
                color: ETheme.colors.second,
                isBold: true,
              ),
            ],
          )),
      nextScreen: const App(),
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: ETheme.colors.backgroundColor,
      splashIconSize: 500,
    )));
  }
}
