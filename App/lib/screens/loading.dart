import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:final_project/cubit/loading_text/loading_text_cubit.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var colorizeColors = [
    ETheme.colors.secondLoading,
    ETheme.colors.primaryLoading,
    ETheme.colors.secondLoading,
    ETheme.colors.primaryLoading,
  ];
  var colorizeTextStyle = const TextStyle(
    fontSize: 25,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    context.read<LoadingTextCubit>().changeText();
    return Scaffold(
      backgroundColor: ETheme.colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animation_lm6kx27k.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
              BlocBuilder<LoadingTextCubit, LoadingTextState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              ColorizeAnimatedText(
                                  textAlign: TextAlign.center,
                                  state.text,
                                  textStyle: colorizeTextStyle,
                                  colors: colorizeColors)
                            ],
                            isRepeatingAnimation: true,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ]),
      ),
    );
  }
}
