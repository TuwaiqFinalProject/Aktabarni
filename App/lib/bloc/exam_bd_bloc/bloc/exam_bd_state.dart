part of 'exam_bd_bloc.dart';

@immutable
sealed class ExamBdState {}

final class ExamBdInitial extends ExamBdState {}

final class GetAllExamsState extends ExamBdState {
  final List<Exam> exam;
  GetAllExamsState(this.exam);
}

final class GetUserExamsState extends ExamBdState {
  final List<Exam> exam;
  GetUserExamsState(this.exam);
}

final class FailedState extends ExamBdState {}

final class FailedIconState extends ExamBdState {}

final class LoadingState extends ExamBdState {}

final class LoadingIconState extends ExamBdState {}

final class InsertState extends ExamBdState {}

final class DeleteState extends ExamBdState {}

final class ChangeExamPrivacyState extends ExamBdState {
  final Exam exam;

  ChangeExamPrivacyState({required this.exam});
}
