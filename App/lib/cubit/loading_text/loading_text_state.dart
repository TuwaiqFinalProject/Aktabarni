part of 'loading_text_cubit.dart';

abstract class LoadingTextState {
  String text;

  LoadingTextState(this.text);
}

final class LoadingTextInitial extends LoadingTextState {
  LoadingTextInitial(super.text);
}

final class ChangeTextState extends LoadingTextState {
  ChangeTextState(super.text);
}

final class LoadingState extends LoadingTextState {
  LoadingState(super.text);
}
