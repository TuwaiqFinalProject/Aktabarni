import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:flutter/material.dart';

class ViewExamCard extends StatelessWidget {
  const ViewExamCard({super.key, required this.exam, required this.index});
  final Exam exam;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
          color: ETheme.colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(25.0)),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: exam.questions![index].question!,
            overflow: TextOverflow.clip,
            isBold: true,
            size: 18,
            fontFamily: 'Tajawal',
            color: const Color.fromARGB(255, 103, 113, 157),
          ),
          kVSpace8,
          const TextWidget(
            text: 'Choices:',
            isBold: true,
            fontFamily: 'Tajawal',
            size: 18,
            color: Color.fromARGB(255, 103, 113, 157),
          ),
          kVSpace8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var choice in exam.questions![index].choices!) ...[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextWidget(
                    text: '- $choice',
                    overflow: TextOverflow.clip,
                    fontFamily: 'Tajawal',
                    size: 18,
                  ),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }
}
