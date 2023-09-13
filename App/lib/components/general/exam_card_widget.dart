import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({
    super.key,
    required this.examName,
    required this.description,
    required this.ownerName,
    required this.createdAt,
  });

  final String examName;
  final String description;
  final String ownerName;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ETheme.colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: ETheme.colors.primary.withOpacity(0.3),
            offset: const Offset(2, 2),
            blurRadius: 2,
            spreadRadius: 2,
          )
        ],
      ),
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
                  text: 'Exam Name: $examName',
                  size: 16,
                  isBold: true,
                  color: ETheme.colors.primary,
                  overflow: TextOverflow.clip,
                ),
              ),
              SizedBox(
                width: 60,
                height: 20,
                child: TextWidget(
                  text: createdAt.substring(0, 10),
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
              text: 'Description: $description',
              fontFamily: 'Tajawal',
              size: 16,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
              overflow: TextOverflow.clip,
            ),
          ),
          SizedBox(
            width: 200,
            height: 20,
            child: TextWidget(
              text: 'Created By: $ownerName',
              fontFamily: 'Tajawal',
              size: 16,
              color: ETheme.colors.primary,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
