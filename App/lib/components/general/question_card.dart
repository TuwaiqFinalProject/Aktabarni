import 'package:final_project/bloc/exam_bd_bloc/bloc/exam_bd_bloc.dart';
import 'package:final_project/bloc/question_button/bloc/question_button_bloc.dart';
import 'package:final_project/components/button/button.dart';
import 'package:final_project/components/general/Sub_question_card.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/screens/result_screen.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    super.key,
    required this.questions,
    // required this.numberOfQuestion,
    required this.index,
    required this.exam,
  });

  final Questions questions;
  // final int numberOfQuestion;
  final Exam exam;
  final int index;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  List<String>? userAnswers;
  @override
  void initState() {
    userAnswers = List.generate(widget.exam.questions!.length, (index) => "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubQuestionCard(widget: widget),
        kVSpace24,
        Column(
          children: [
            for (var element in widget.questions.choices!) ...[
              Button(
                text: element,
                textSize: 18,
                fontFamily: 'Tajawal',
                backgroundColor: userAnswers![widget.index] == element
                    ? ETheme.colors.second
                    : ETheme.colors.primary,
                onPress: () {
                  print("answer data: ${widget.questions.correctAnswer}");
                  print(
                      "answer type: ${widget.questions.correctAnswer.runtimeType}");
                  userAnswers![widget.index] = element;
                  setState(() {});
                },
                borderRadius: 25,
                btnHigth: 55,
                btnWidth: context.getWidth - 80,
                color: ETheme.colors.white,
              ),
              kVSpace16
            ],
            kHSpace24,
            BlocBuilder<QuestionButtonBloc, QuestionButtonState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                              visible: state.index != 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: ETheme.colors.primary,
                                  size: 42,
                                ),
                                onPressed: () {
                                  context
                                      .read<QuestionButtonBloc>()
                                      .add(BackButtonEvent());
                                },
                              )),
                          Visibility(
                            visible: state.index + 1 !=
                                widget.exam.questions!.length,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                color: ETheme.colors.primary,
                                size: 42,
                              ),
                              onPressed: () {
                                context
                                    .read<QuestionButtonBloc>()
                                    .add(NextButtonEvent());
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: state.index + 1 == widget.exam.questions!.length,
                      child: Button(
                        text: "Submit",
                        textSize: 18,
                        btnWidth: context.getWidth - 150,
                        color: ETheme.colors.white,
                        btnHigth: 32,
                        backgroundColor: ETheme.colors.second,
                        onPress: () async {
                          // context
                          //     .read<ExamBdBloc>()
                          //     .add(InsertExamEvent(exam: widget.exam));
                          state.index = 0;

                          context.pushNav(
                              screen: ResultScreen(
                                  exam: widget.exam,
                                  userAnswers: userAnswers!));
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
