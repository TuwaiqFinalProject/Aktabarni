import 'package:final_project/bloc/bloc/gpt_bloc.dart';
import 'package:final_project/bloc/exam_bd_bloc/bloc/exam_bd_bloc.dart';
import 'package:final_project/components/general/glass_card_widget.dart';
import 'package:final_project/components/general/upload_card_widget.dart';
import 'package:final_project/components/button/close_button_In_create_exam.dart';
import 'package:final_project/components/questions_type_widget.dart';
import 'package:final_project/components/text/text_field_widget.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/cubit/craet_exam_button/cubit/createxambutton_cubit.dart';
import 'package:final_project/models/request_data.dart';
import 'package:final_project/screens/exam_screen.dart';
import 'package:final_project/screens/loading.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateExam extends StatefulWidget {
  const CreateExam({super.key});

  @override
  State<CreateExam> createState() => _CreateExamState();
}

class _CreateExamState extends State<CreateExam> {
  int currentStep = 0;
  TextEditingController? examNameController = TextEditingController();
  TextEditingController? examDescriptionController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    examNameController!.dispose();
    examDescriptionController!.dispose();
    super.dispose();
  }

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
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  const CloseButtonInCreateExam(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 50),
                    child: Theme(
                      data: ThemeData(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                              primary: ETheme.colors.primary,
                            ),
                      ),
                      child: Center(
                        child: BlocConsumer<GptBloc, GptState>(
                          listener: (context, state) {
                            if (state is GetExamState) {
                              context
                                  .read<ExamBdBloc>()
                                  .add(InsertExamEvent(exam: state.exam));
                              context.pushNav(
                                  screen: ExamScreen(
                                exam: state.exam,
                              ));
                            }
                            if (state is LoadinGetExamgState) {
                              context.pushNav(screen: const LoadingScreen());
                            }
                          },
                          builder: (context, state) {
                            return Column(
                              children: [
                                Stepper(
                                  margin: const EdgeInsets.all(50),
                                  elevation: 0,
                                  type: StepperType.vertical,
                                  steps: buildSteps(),
                                  onStepTapped: (int newIndex) {
                                    setState(() {
                                      currentStep = newIndex;
                                    });
                                  },
                                  currentStep: currentStep,
                                  onStepContinue: () async {
                                    if (currentStep != 3) {
                                      setState(() {
                                        currentStep += 1;
                                      });
                                    } else if (currentStep == 3) {
                                      context.read<GptBloc>().add(
                                          SubmitFileEvent(
                                              examName:
                                                  examNameController!.text,
                                              examDescription:
                                                  examDescriptionController!
                                                      .text));
                                    }
                                  },
                                  onStepCancel: () {
                                    if (currentStep != 0) {
                                      setState(() {
                                        currentStep -= 1;
                                      });
                                    }
                                  },
                                  controlsBuilder: (context, details) {
                                    return BlocBuilder<CreatExamButtonCubit,
                                        CreatExamButtonState>(
                                      builder: (context, state) {
                                        return Row(
                                          children: [
                                            currentStep == 3
                                                ? ElevatedButton(
                                                    onPressed: state.canGoNext
                                                        ? details.onStepContinue
                                                        : null,
                                                    // details.onStepContinue,
                                                    child: const Text("Create"))
                                                : ElevatedButton(
                                                    onPressed:
                                                        details.onStepContinue,
                                                    child: const Text("Next")),
                                            kHSpace8,
                                            currentStep == 0
                                                ? Container()
                                                : OutlinedButton(
                                                    onPressed:
                                                        details.onStepCancel,
                                                    child: const Text("Back"))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Step> buildSteps() {
    return [
      Step(
        isActive: currentStep >= 0,
        title: const TextWidget(
          text: "Select file",
          size: 17,
          fontFamily: 'Tajawal',
        ),
        content: Column(
          children: [
            Center(
              child: InkWell(
                // onTap: GPTService().selectPdf,
                child: UploadCard(
                  icon: Icon(
                    Icons.file_present_outlined,
                    size: 20,
                    color: ETheme.colors.white,
                  ),
                ),
              ),
            ),
            kVSpace24
          ],
        ),
      ),
      Step(
        isActive: currentStep >= 1,
        title: const TextWidget(
          text: "Questions type",
          size: 17,
          fontFamily: 'Tajawal',
        ),
        content: Column(
          children: [
            CheckboxWidget(
              color: Data.typOfQuestions == "True or false"
                  ? ETheme.colors.primary
                  : ETheme.colors.backgroundColor,
              onTap: () {
                context.read<CreatExamButtonCubit>().checkValidate(type: true);
                context.read<GptBloc>().add(QuestionTypeEvent("True or false"));
              },
              data: "True or false",
            ),
            CheckboxWidget(
              color: Data.typOfQuestions == "multiple choices"
                  ? ETheme.colors.primary
                  : ETheme.colors.backgroundColor,
              onTap: () {
                context.read<CreatExamButtonCubit>().checkValidate(type: true);
                context
                    .read<GptBloc>()
                    .add(QuestionTypeEvent("multiple choices"));
              },
              data: "Choices",
            ),
            kVSpace24
          ],
        ),
      ),
      Step(
        isActive: currentStep >= 2,
        title: const TextWidget(
            text: "Number of questions", size: 17, fontFamily: 'Tajawal'),
        content: Column(
          children: [
            CheckboxWidget(
              color: Data.numberOfQuestions == 2
                  ? ETheme.colors.primary
                  : ETheme.colors.backgroundColor,
              onTap: () {
                context
                    .read<CreatExamButtonCubit>()
                    .checkValidate(questions: true);
                context.read<GptBloc>().add(QuestionNumberEvent(2));
              },
              data: "2",
            ),
            CheckboxWidget(
              color: Data.numberOfQuestions == 3
                  ? ETheme.colors.primary
                  : ETheme.colors.backgroundColor,
              onTap: () {
                context
                    .read<CreatExamButtonCubit>()
                    .checkValidate(questions: true);
                context.read<GptBloc>().add(QuestionNumberEvent(3));
              },
              data: "3",
            ),
            kVSpace24
          ],
        ),
      ),
      Step(
        isActive: currentStep >= 3,
        title: const TextWidget(
            text: "Exam information", size: 17, fontFamily: 'Tajawal'),
        content: Column(
          children: [
            TextFieldWidget(
              hint: 'ex. Database',
              lable: 'Exam name',
              textLabelSize: 16,
              controller: examNameController,
              onSubmitted: (value) {
                context
                    .read<CreatExamButtonCubit>()
                    .checkValidate(examInfo: value.isNotEmpty);
              },
            ),
            kVSpace8,
            TextFieldWidget(
              hint: 'ex. chapter 1',
              lable: 'Exam description',
              textLabelSize: 16,
              controller: examDescriptionController,
            ),
          ],
        ),
      ),
    ];
  }
}
