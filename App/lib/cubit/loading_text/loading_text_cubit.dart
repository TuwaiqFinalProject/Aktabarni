import 'package:bloc/bloc.dart';
import 'package:final_project/functions/loading_list/loading_list.dart';

part 'loading_text_state.dart';

class LoadingTextCubit extends Cubit<LoadingTextState> {
  LoadingTextCubit() : super(LoadingTextInitial(loadingTextList[0]));

  changeText() async {
    for (var elemnt in loadingTextList) {
      await Future.delayed(const Duration(seconds: 1), () {
        emit(ChangeTextState(elemnt));
      });
    }
  }
  // changeText() {
  //   int i = 0;
  //   while (true) {
  //     Future.delayed(Duration(seconds: 2), () {
  //       emit(ChangeTextState(loadingTextList[i]));
  //     });
  //     i++ % loadingTextList.length;
  //   }
  // }
}
