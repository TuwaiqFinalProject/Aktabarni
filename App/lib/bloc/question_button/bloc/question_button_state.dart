// ignore_for_file: must_be_immutable

part of 'question_button_bloc.dart';

@immutable
sealed class QuestionButtonState {
  int index;

  QuestionButtonState(this.index);
}

final class QuestionButtonInitial extends QuestionButtonState {
  QuestionButtonInitial(super.index);
}

final class GetQuestionButtonState extends QuestionButtonState {
  GetQuestionButtonState(super.index);
}
