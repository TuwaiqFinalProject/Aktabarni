import 'package:final_project/components/general/expanded_exam_card.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:flutter/material.dart';

searchResult(String inputExam, List<Exam> allExams) {
  List<Exam> resultList = [];
  for (var exam in allExams) {
    if (exam.name!.toLowerCase().contains(inputExam.toLowerCase())) {
      resultList.add(exam);
    }
  }
  if (resultList.isEmpty) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: TextWidget(
        text: "Sorry the exam you looking for is not found 🙁 ",
        textAlign: TextAlign.center,
      ),
    ));
  } else {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: resultList.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.zero,
          child: ExpandedExamCard(
            exam: resultList[index],
          ),
        );
      },
    );
  }
}
