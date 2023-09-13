import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'createxambutton_state.dart';

class CreatExamButtonCubit extends Cubit<CreatExamButtonState> {
  CreatExamButtonCubit() : super(const CreatExamButtonInitial(false));
  bool type = false;
  bool questions = false;
  bool fileUploaded = false;
  bool examInfo = false;

  checkValidate(
      {bool? type, bool? questions, bool? fileUploaded, bool? examInfo}) {
    type == true ? this.type = true : this.type;
    questions == true ? this.questions = true : this.questions;
    fileUploaded == true ? this.fileUploaded = true : this.fileUploaded;
    examInfo == true ? this.examInfo = true : this.examInfo;

    print(
        "type: ${this.type} - questions: ${this.questions} - file ${this.fileUploaded} - examInfo: ${this.examInfo}");
    emit(GetExamButtonState(
        (this.type && this.questions && this.fileUploaded && this.examInfo)));
  }
}
