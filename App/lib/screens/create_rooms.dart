import 'package:final_project/components/button/close_button_In_create_exam.dart';
import 'package:final_project/components/general/upload_card_widget.dart';

import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:flutter/material.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ETheme.colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: [
            const CloseButtonInCreateExam(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Theme(
                data: ThemeData(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: ETheme.colors.primary,
                      ),
                ),
                child: Center(
                  child: Column(
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
                        onStepContinue: () {
                          if (currentStep != 2) {
                            setState(() {
                              currentStep += 1;
                            });
                          }
                          //  else if (currentStep == 2) {
                          //   context.pushNav(screen: NavigationBarScreen());
                          // }
                        },
                        onStepCancel: () {
                          if (currentStep != 0) {
                            setState(() {
                              currentStep -= 1;
                            });
                          }
                        },
                        controlsBuilder: (context, details) {
                          return Row(
                            children: [
                              ElevatedButton(
                                  onPressed: details.onStepContinue,
                                  child: const Text("Next")),
                              kHSpace8,
                              currentStep == 0
                                  ? Container()
                                  : OutlinedButton(
                                      onPressed: details.onStepCancel,
                                      child: const Text("Back"))
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Step> buildSteps() {
    return [
      Step(
        isActive: currentStep >= 0,
        title: const Text("Add Image "),
        content: const Column(
          children: [
            Center(
              child: UploadCard(
                icon: Icon(Icons.image),
              ),
            ),
            kVSpace24
          ],
        ),
      ),
      Step(
        isActive: currentStep >= 1,
        title: const Text("Title of room"),
        content: const Column(
          children: [kVSpace24],
        ),
      ),
      Step(
        isActive: currentStep >= 2,
        title: const Text("Code"),
        content: const Column(
          children: [kVSpace24],
        ),
      ),
    ];
  }
}
