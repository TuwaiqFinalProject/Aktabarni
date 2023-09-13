import 'package:bloc/bloc.dart';
import 'package:final_project/models/exam_model.dart';
import 'package:final_project/services/database/exams_queries.dart';
import 'package:meta/meta.dart';

part 'exam_bd_event.dart';
part 'exam_bd_state.dart';

class ExamBdBloc extends Bloc<ExamBdEvent, ExamBdState> {
  ExamBdBloc() : super(ExamBdInitial()) {
    on<GetAllExamsEvent>((event, emit) async {
      List<Exam> exams = [];
      emit(LoadingState());

      try {
        exams = await SupabaseService().getAllExams();
        emit(GetAllExamsState(exams));
      } catch (e) {
        emit(FailedState());
      }
    });

    on<GetUserExamsEvent>((event, emit) async {
      List<Exam> exams = [];
      emit(LoadingState());

      try {
        exams = await SupabaseService().getUserExams();
        emit(GetUserExamsState(exams));
      } catch (e) {
        emit(FailedState());
      }
    });

    on<InsertExamEvent>((event, emit) async {
      emit(LoadingState());
      try {
        await SupabaseService().insertExam(event.exam);
        emit(InsertState());
      } catch (e) {
        emit(FailedState());
      }
    });

    on<ChangeExamPrivacyEvent>((event, emit) async {
      List<Exam> exams = [];
      emit(LoadingState());
      try {
        await SupabaseService().changeExamPrivacy(event.exam);
        exams = await SupabaseService().getUserExams();
        emit(GetUserExamsState(exams));
      } catch (e) {
        emit(FailedState());
      }
    });

    on<DeleteExamEvent>((event, emit) async {
      List<Exam> exams = [];
      emit(LoadingState());
      try {
        await SupabaseService().deleteExam(event.exam);
        exams = await SupabaseService().getUserExams();
        emit(GetUserExamsState(exams));
      } catch (e) {
        emit(FailedState());
      }
    });
  }
}
