part of 'gpt_bloc.dart';

abstract class GptEvent {}

class UploadFileEvent extends GptEvent {}

class SubmitFileEvent extends GptEvent {
  final String examName;
  final String examDescription;

  SubmitFileEvent({required this.examName, required this.examDescription});
}

class QuestionTypeEvent extends GptEvent {
  final String typOfQuestions;
  QuestionTypeEvent(this.typOfQuestions);
}

class QuestionNumberEvent extends GptEvent {
  final int numberOfQuestions;
  QuestionNumberEvent(this.numberOfQuestions);
}

// class ExamNameEvent extends GptEvent {
//   ExamNameEvent(this.examName);
// }

// class ExamDescriptionEvent extends GptEvent {
//   ExamDescriptionEvent(this.examDescription);
// }
