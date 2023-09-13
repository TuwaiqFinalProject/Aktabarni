import 'package:bloc/bloc.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/models/request_data.dart';
import 'package:final_project/services/chatgpt.dart';
import 'package:meta/meta.dart';

part 'gpt_event.dart';
part 'gpt_state.dart';

class GptBloc extends Bloc<GptEvent, GptState> {
  GptBloc() : super(GptInitial()) {
    on<UploadFileEvent>((event, emit) async {
      emit(LoadinFileUploadgState());

      try {
        bool isUploaded = await GPTService().selectPdf();
        if (isUploaded) {
          emit(UploadFileState(true));
        } else {
          emit(FailedState());
        }
      } catch (e) {
        emit(FailedState());
      }
    });

    on<QuestionTypeEvent>((event, emit) async {
      try {
        Data.typOfQuestions = event.typOfQuestions;
        emit(QuestionParameterState());
      } catch (e) {
        emit(FailedState());
      }
    });

    on<QuestionNumberEvent>((event, emit) async {
      try {
        Data.numberOfQuestions = event.numberOfQuestions;
        emit(QuestionParameterState());
      } catch (e) {
        emit(FailedState());
      }
    });

    on<SubmitFileEvent>((event, emit) async {
      emit(LoadinGetExamgState());

      try {
        if (Data.numberOfQuestions != null && Data.typOfQuestions != null) {
          Exam exam = await GPTService().getExam();
          exam.name = event.examName;
          exam.description = event.examDescription;
          emit(GetExamState(exam));
        }
      } catch (e) {
        emit(FailedState());
      }
    });
  }
}
