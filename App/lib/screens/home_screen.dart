import 'package:final_project/bloc/exam_bd_bloc/bloc/exam_bd_bloc.dart';
import 'package:final_project/components/general/expanded_exam_card.dart';
import 'package:final_project/components/general/glass_card_widget.dart';
import 'package:final_project/components/text/text_field_widget.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/functions/search_result.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/services/database/exams_queries.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController? searchController;
  List<Exam> allExams = [];
  bool isSubmitted = false;
  getAllExams() async {
    allExams = await SupabaseService().getAllExams();
  }

  @override
  void initState() {
    searchController = TextEditingController();
    getAllExams();
    super.initState();
  }

  @override
  void dispose() {
    searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ExamBdBloc>().add(GetAllExamsEvent());
    return Scaffold(
        backgroundColor: ETheme.colors.backgroundColor,
        resizeToAvoidBottomInset: false,
        body: Center(
            child: GlassCard(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              TextFieldWidget(
                controller: searchController,
                onChanged: (value) {
                  searchController!.text == value;
                  isSubmitted = true;
                  setState(() {});
                },
                preIcon: const Icon(Icons.search),
                hint: 'Search',
                lable: '',
                radius: 35,
              ),
              isSubmitted
                  ? searchResult(searchController!.text, allExams)
                  : BlocBuilder<ExamBdBloc, ExamBdState>(
                      builder: (context, state) {
                        print('1 state from home: $state');
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
                        if (state is GetAllExamsState) {
                          List<Exam> allExams = state.exam;
                          final allExamsReversed = allExams.reversed;
                          allExams = allExamsReversed.toList();
                          return SizedBox(
                            height: context.getHeight - 200,
                            child:
                                ListView(padding: EdgeInsets.zero, children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: allExams.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.zero,
                                    child: ExpandedExamCard(
                                      exam: allExams[index],
                                    ),
                                  );
                                },
                              ),
                            ]),
                          );
                        }
                        return const Column(
                          children: [
                            kVSpace128,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 8),
                              child: TextWidget(
                                  text: "Sorry no one post any exams yet 🙁"),
                            ),
                          ],
                        );
                      },
                    ),
              kVSpace128,
            ],
          ),
        )));
  }
}
