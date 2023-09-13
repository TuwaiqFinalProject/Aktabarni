import 'package:final_project/bloc/question_button/bloc/question_button_bloc.dart';
import 'package:final_project/components/general/glass_card_widget.dart';
import 'package:final_project/components/general/question_card.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ExamScreen extends StatelessWidget {
  const ExamScreen({super.key, this.timer = false, required this.exam});
  final bool timer;
  final Exam exam;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ETheme.colors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Center(
            child: GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kVSpace8,
              timer
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Lottie.asset(
                                      'assets/animation_lm86zwqt.json',
                                      height: 24,
                                      width: 24),
                                ),
                                TextWidget(
                                  text: '10 min',
                                  color: ETheme.colors.primary,
                                ),
                                kVSpace8
                              ],
                            ),
                            kHSpace24,
                          ],
                        ),
                      ],
                    )
                  : kVSpace64,
              kVSpace32,
              BlocBuilder<QuestionButtonBloc, QuestionButtonState>(
                builder: (context, state) {
                  return QuestionCard(
                    questions: exam.questions![state.index],
                    // numberOfQuestion: exam.questions!.length,
                    exam: exam,
                    index: state.index,
                  );
                },
              ),
            ],
          ),
        )));
  }
}
