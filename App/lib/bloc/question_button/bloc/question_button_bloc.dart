import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'question_button_event.dart';
part 'question_button_state.dart';

class QuestionButtonBloc
    extends Bloc<QuestionButtonEvent, QuestionButtonState> {
  QuestionButtonBloc() : super(QuestionButtonInitial(0)) {
    on<NextButtonEvent>((event, emit) {
      emit(GetQuestionButtonState(state.index + 1));
    });
    on<BackButtonEvent>((event, emit) {
      if (state.index > 0) {
        emit(GetQuestionButtonState(state.index - 1));
      }
    });
  }
}
