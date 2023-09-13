import 'package:final_project/bloc/bloc/gpt_bloc.dart';
import 'package:final_project/bloc/exam_bd_bloc/bloc/exam_bd_bloc.dart';
import 'package:final_project/bloc/question_button/bloc/question_button_bloc.dart';
import 'package:final_project/cubit/calender/calender_cubit.dart';
import 'package:final_project/cubit/craet_exam_button/cubit/createxambutton_cubit.dart';
import 'package:final_project/cubit/loading_text/loading_text_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialBlocProvidersList extends StatelessWidget {
  const MaterialBlocProvidersList({
    super.key,
    required this.home,
  });
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoadingTextCubit(),
        ),
        BlocProvider(
          create: (context) => GptBloc(),
        ),
        BlocProvider(
          create: (context) => CreatExamButtonCubit(),
        ),
        BlocProvider(
          create: (context) => QuestionButtonBloc(),
        ),
        BlocProvider(
          create: (context) => ExamBdBloc(),
        ),
        BlocProvider(
          create: (context) => CalenderCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: home,
      ),
    );
  }
}
