import 'package:flutter/material.dart';

enum AppTheme { dark, light }

ETheme theme(AppTheme theme) {
  return switch (theme) {
    AppTheme.light => ETheme(
        backgroundColor: const Color(0xffd0d9ea),
        second: const Color(0xff2a3d6d),
        primary: const Color.fromRGBO(129, 140, 188, 1),
        primaryLoading: const Color(0xff26eca3),
        secondLoading: const Color(0xff00a6f2),
        textColor: const Color.fromARGB(255, 148, 146, 143),
        white: const Color(0xffeff3fc),
        black: Colors.black,
        red: Colors.red,
      ),
    AppTheme.dark => ETheme(
        backgroundColor: const Color(0xff2a3d6d),
        second: const Color(0xffd0d9ea),
        primary: Color.fromARGB(
            255, 84, 104, 191), //const Color.fromRGBO(129, 140, 188, 1),
        primaryLoading: const Color(0xff26eca3),
        secondLoading: const Color(0xff00a6f2),
        textColor: const Color.fromARGB(255, 148, 146, 143),
        white: const Color.fromARGB(255, 69, 69, 69),
        black: const Color.fromARGB(255, 249, 249, 249),
        red: Colors.red,
      ),
  };
}

// const Color.fromARGB(255, 97, 97, 97)
class ETheme {
  static AppTheme currentTheme = AppTheme.light;

  static ETheme get colors => theme(currentTheme);

  final Color backgroundColor;
  final Color primary;
  final Color second;
  final Color primaryLoading;
  final Color secondLoading;
  final Color textColor;
  final Color white;
  final Color black;
  final Color red;

  ETheme({
    required this.backgroundColor,
    required this.primary,
    required this.second,
    required this.primaryLoading,
    required this.secondLoading,
    required this.textColor,
    required this.white,
    required this.black,
    required this.red,
  });
}

const Color primary2 = Color.fromRGBO(129, 140, 188, 1);
