// ignore_for_file: must_be_immutable

part of 'exam_bd_bloc.dart';

@immutable
sealed class ExamBdEvent {}

final class GetAllExamsEvent extends ExamBdEvent {}

final class GetUserExamsEvent extends ExamBdEvent {}

final class InsertExamEvent extends ExamBdEvent {
  Exam exam;
  InsertExamEvent({required this.exam});
}

final class ChangeExamPrivacyEvent extends ExamBdEvent {
  Exam exam;
  ChangeExamPrivacyEvent({required this.exam});
}

final class DeleteExamEvent extends ExamBdEvent {
  Exam exam;
  DeleteExamEvent({required this.exam});
}
