import 'package:final_project/app.dart';
import 'package:final_project/bloc/exam_bd_bloc/bloc/exam_bd_bloc.dart';
import 'package:final_project/components/general/expanded_exam_card.dart';
import 'package:final_project/components/general/glass_card_widget.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/services/database/exams_queries.dart';
import 'package:final_project/services/database/user_data.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final currentUserId = SupabaseData.client.auth.currentSession?.user.id;
final currentUserEmail = SupabaseData.client.auth.currentSession?.user.email;
bool notificationSwitchValue = false;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<ExamBdBloc>().add(GetUserExamsEvent());

    return Scaffold(
      backgroundColor: ETheme.colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Center(
          child: GlassCard(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            kVSpace64,
            FutureBuilder(
              future: SupabaseData().getUserName(userId: currentUserId),
              builder: (context, snapshot) {
                return Column(children: [
                  TextWidget(
                      text: "Hello, ${snapshot.data?.name.toString() ?? ''}",
                      color: ETheme.colors.primary,
                      isBold: true,
                      size: 18),
                  kVSpace8,
                  TextWidget(
                      text: "Email : ${currentUserEmail ?? ''}",
                      fontFamily: 'Tajawal',
                      color: ETheme.colors.primary,
                      isBold: false,
                      size: 18),
                  kVSpace16,
                ]);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    SupabaseData.client.auth.signOut();
                    context.pushAndRemoveNav(screen: const App());
                  },
                  child: const TextWidget(
                    text: 'Sing out',
                    color: Colors.red,
                    isBold: true,
                    size: 16,
                    fontFamily: 'Tajawal',
                  ),
                ),
                kHSpace8,
                Icon(
                  Icons.output,
                  size: 16,
                  color: ETheme.colors.red,
                )
              ],
            ),
            kVSpace16,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RollerButton(
                //   title: 'Theme', // Third button title
                //   switchValue:
                //       notificationSwitchValue, // Third button switch value
                //   onChanged: (bool value) {
                //     value
                //         ? ETheme.currentTheme = AppTheme.dark
                //         : ETheme.currentTheme = AppTheme.light;
                //     print('something...${AppTheme.values}');
                //     setState(() {
                //       notificationSwitchValue = value;
                //     });
                //   },
                // ),
                TextWidget(
                  text: "Previous Exams",
                  fontFamily: 'Tajawal',
                  color: ETheme.colors.primary,
                  size: 18,
                  isBold: true,
                ),
                TextWidget(
                  text: "Swap to left to delete exam",
                  fontFamily: 'Tajawal',
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                  size: 18,
                  isBold: true,
                ),
                BlocBuilder<ExamBdBloc, ExamBdState>(
                  builder: (context, state) {
                    print('1 state: $state');
                    if (state is LoadingState) {
                      return Column(
                        children: [
                          kVSpace128,
                          Center(
                              child: CircularProgressIndicator(
                                  color: ETheme.colors.primary)),
                        ],
                      );
                    }
                    if (state is GetUserExamsState) {
                      List<Exam> allExams = state.exam;
                      final allExamsReversed = allExams.reversed;
                      allExams = allExamsReversed.toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: allExams.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (_) async {
                              await SupabaseService()
                                  .deleteExam(allExams[index]);
                            },
                            // This will show up when the user performs dismissal action
                            // It is a red background and a trash icon
                            background: Container(
                              color: Colors.red,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),

                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: context.getWidth,
                                ),
                                Container(
                                  padding: EdgeInsets.zero,
                                  child: ExpandedExamCard(
                                    exam: allExams[index],
                                  ),
                                ),
                                Positioned(
                                    right: 35,
                                    top: 55,
                                    child: InkWell(
                                        onTap: () {
                                          context.read<ExamBdBloc>().add(
                                              ChangeExamPrivacyEvent(
                                                  exam: allExams[index]));
                                        },
                                        child: allExams[index].isPublic!
                                            ? Icon(
                                                Icons.lock_open_sharp,
                                                color: ETheme.colors.primary,
                                              )
                                            : Icon(
                                                Icons.lock_outline,
                                                color: ETheme.colors.primary,
                                              ))),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    if (state is FailedState) {
                      return const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                        child: TextWidget(
                          text: "Failed",
                          size: 17,
                          fontFamily: 'Tajawal',
                        ),
                      );
                    }
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                      child: TextWidget(
                        text: "Sorry you don't have previous exams yet 🙁",
                        size: 17,
                        fontFamily: 'Tajawal',
                      ),
                    );
                  },
                ),
              ],
            ),
            kVSpace128
          ],
        ),
      )),
    );
  }
}
