import 'package:final_project/components/general/question_card.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';

class SubQuestionCard extends StatelessWidget {
  const SubQuestionCard({
    super.key,
    required this.widget,
  });

  final QuestionCard widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: ETheme.colors.primary.withOpacity(0.80),
          ),
          width: context.getWidth - 70,
          height: 200,
        ),
        Positioned(
          left: 16,
          top: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: ETheme.colors.primary.withOpacity(0.60),
            ),
            width: context.getWidth - 100,
            height: 180,
          ),
        ),
        Positioned(
            right: 1,
            child: Icon(Icons.question_mark,
                size: 130, color: const Color(0xff071952).withOpacity(0.2))),
        Positioned(
          top: 50,
          left: 55,
          bottom: 30,
          child: SizedBox(
            width: context.getWidth - 150,
            // height: 200,
            child: ListView(shrinkWrap: true, children: [
              TextWidget(
                size: 20,
                text: '${widget.questions.question}',
                color: ETheme.colors.white,
                fontFamily: 'Tajawal',
                overflow: TextOverflow.clip,
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
