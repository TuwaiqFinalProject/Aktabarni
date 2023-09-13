import 'package:dotted_border/dotted_border.dart';
import 'package:final_project/bloc/bloc/gpt_bloc.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/cubit/craet_exam_button/cubit/createxambutton_cubit.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadCard extends StatelessWidget {
  const UploadCard({
    super.key,
    required this.icon,
    this.text,
    this.bgColor,
  });
  final Widget icon;
  final String? text;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<GptBloc>().add(UploadFileEvent());
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: bgColor ?? ETheme.colors.primary),
          width: context.getWidth - 150,
          height: context.getHeight / 5,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            padding: const EdgeInsets.all(25),
            strokeWidth: 1,
            child: Center(
              child: BlocBuilder<GptBloc, GptState>(
                builder: (context, state) {
                  if (state is UploadFileState) {
                    context
                        .read<CreatExamButtonCubit>()
                        .checkValidate(fileUploaded: true);
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.done,
                            color: ETheme.colors.white,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextWidget(
                              text: text ?? 'Uploaded susseccfully',
                              size: 16,
                              fontFamily: 'Tajawal',
                              color: ETheme.colors.white,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]);
                  } else if (state is LoadinFileUploadgState) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: ETheme.colors.white),
                    );
                  } else {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          icon,
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextWidget(
                              text: text ?? 'Upload file',
                              size: 16,
                              fontFamily: 'Tajawal',
                              color: ETheme.colors.white,
                            ),
                          )
                        ]);
                  }
                },
              ),
            ),
          )),
    );
  }
}
