import 'package:final_project/components/general/glass_card_widget.dart';
import 'package:final_project/components/general/view_exam_card.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';

class ViewExam extends StatelessWidget {
  const ViewExam({super.key, required this.exam});
  final Exam exam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ETheme.colors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Center(
            child: GlassCard(
                width: context.getWidth - 30,
                height: context.getHeight - 30,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    kVSpace16,
                    Row(
                      children: [
                        kHSpace16,
                        InkWell(
                          onTap: () {
                            context.popNav();
                          },
                          child: Icon(
                            Icons.arrow_circle_left_outlined,
                            color: ETheme.colors.primary,
                            size: 30,
                          ),
                        ),
                        // Spacer(),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16),
                        //   child: InkWell(
                        //     onTap: () {
                        //       SaveFile.savePDF(exam.questions.toString());
                        //     },
                        //     child: Icon(
                        //       Icons.cloud_download_outlined,
                        //       color: ETheme.colors.primary,
                        //       size: 30,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    Center(
                        child: TextWidget(
                      color: const Color.fromARGB(255, 103, 113, 157),
                      text: 'Exam Name: ${exam.name}',
                      size: 17,
                      fontFamily: 'Tajawal',
                      isBold: true,
                      overflow: TextOverflow.clip,
                    )),
                    kVSpace8,
                    Center(
                        child: TextWidget(
                      text: 'Exam Description: ${exam.description}',
                      overflow: TextOverflow.clip,
                      color: const Color.fromARGB(255, 103, 113, 157),
                      fontFamily: 'Tajawal',
                      size: 16,
                    )),
                    kVSpace16,
                    SizedBox(
                      height: context.getHeight - 150,
                      child: ListView(children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: exam.questions!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ViewExamCard(
                              exam: exam,
                              index: index,
                            );
                          },
                        ),
                      ]),
                    )
                  ],
                ))));
  }
}
