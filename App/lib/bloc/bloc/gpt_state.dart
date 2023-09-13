part of 'gpt_bloc.dart';

@immutable
sealed class GptState {}

final class GptInitial extends GptState {}

final class GetExamState extends GptState {
  final Exam exam;
  GetExamState(this.exam);
}

final class QuestionParameterState extends GptState {}

final class UploadFileState extends GptState {
  final bool fileUploaded;

  UploadFileState(this.fileUploaded);
}

final class FailedState extends GptState {}

final class LoadinFileUploadgState extends GptState {}

final class LoadinGetExamgState extends GptState {}
