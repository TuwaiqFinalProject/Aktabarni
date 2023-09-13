import 'package:final_project/components/button/button.dart';
import 'package:final_project/components/general/glass_card_widget.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/screens/navigation_bar_screen.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// ignore: must_be_immutable
class ResultScreen extends StatefulWidget {
  ResultScreen({super.key, required this.exam, required this.userAnswers});
  final Exam exam;
  List<String> userAnswers;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int result = 0;
  @override
  void initState() {
    for (var i = 0; i < widget.userAnswers.length; i++) {
      if (widget.userAnswers[i] == widget.exam.questions![i].correctAnswer) {
        result++;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ETheme.colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: GlassCard(
          child: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kVSpace128,
                    TextWidget(
                      size: 24,
                      color: ETheme.colors.second,
                      text:
                          'Your result is $result out of  ${widget.exam.questions!.length}',
                    ),
                    kVSpace32,
                    CircularPercentIndicator(
                      radius: 100,
                      lineWidth: 14.5,
                      percent: result / widget.userAnswers.length,
                      progressColor: ETheme.colors.second,
                      backgroundColor: ETheme.colors.primary,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: TextWidget(
                        size: 24,
                        color: ETheme.colors.second,
                        text:
                            "${(result / widget.userAnswers.length * 100).toStringAsFixed(2)}%",
                      ),
                    ),
                  ],
                ),
              ),
              kVSpace64,
              Column(
                children: [
                  Button(
                    btnWidth: context.getWidth - 200,
                    text: 'Home',
                    color: ETheme.colors.white,
                    backgroundColor: ETheme.colors.primary,
                    onPress: () =>
                        context.pushNav(screen: const NavigationBarScreen()),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
