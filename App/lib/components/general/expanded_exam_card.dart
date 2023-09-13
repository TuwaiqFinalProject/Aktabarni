import 'package:final_project/components/button/button.dart';
import 'package:final_project/components/general/exam_card_widget.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/screens/exam_screen.dart';
import 'package:final_project/screens/view_exam_screen.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';

class ExpandedExamCard extends StatefulWidget {
  const ExpandedExamCard({
    super.key,
    required this.exam,
  });

  final Exam exam;

  @override
  State<ExpandedExamCard> createState() => _ExpandedExamCardState();
}

bool isExpanded = false;

class _ExpandedExamCardState extends State<ExpandedExamCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isExpanded = !isExpanded;
        setState(() {});
      },
      child: Column(
        children: [
          isExpanded
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ETheme.colors.primary.withOpacity(0.3),
                          offset: const Offset(2, 2),
                          blurRadius: 2,
                          spreadRadius: 2,
                        )
                      ],
                      color: ETheme.colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  width: context.getWidth - 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 20,
                            child: TextWidget(
                              text: 'Exam Name: ${widget.exam.name}',
                              size: 15,
                              isBold: true,
                              color: ETheme.colors.primary,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            height: 20,
                            child: TextWidget(
                              text: widget.exam.createdAt!.substring(0, 10),
                              size: 9,
                              isBold: true,
                              color: ETheme.colors.primary,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 200,
                        height: 20,
                        child: TextWidget(
                          text: 'Description: ${widget.exam.description}',
                          fontFamily: 'Tajawal',
                          fontStyle: FontStyle.italic,
                          size: 16,
                          color: Colors.grey,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 20,
                        child: TextWidget(
                          text: 'Created By: ${widget.exam.userOwnerName}',
                          fontFamily: 'Tajawal',
                          size: 16,
                          color: ETheme.colors.primary,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Button(
                            text: 'Take Exam',
                            backgroundColor: ETheme.colors.primary,
                            onPress: () {
                              context.pushNav(
                                  screen: ExamScreen(exam: widget.exam));
                            },
                            textSize: 15,
                            btnHigth: 10,
                            btnWidth: context.getWidth / 3,
                            color: ETheme.colors.white,
                          ),
                          Button(
                            text: 'View exam',
                            backgroundColor: ETheme.colors.primary,
                            onPress: () {
                              context.pushNav(
                                  screen: ViewExam(exam: widget.exam));
                            },
                            textSize: 15,
                            btnHigth: 10,
                            btnWidth: context.getWidth / 3,
                            color: ETheme.colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                )
              : ExamCard(
                  examName: '${widget.exam.name}',
                  description: '${widget.exam.description}',
                  ownerName: '${widget.exam.userOwnerName}',
                  createdAt: '${widget.exam.createdAt}',
                )
        ],
      ),
    );
  }
}
