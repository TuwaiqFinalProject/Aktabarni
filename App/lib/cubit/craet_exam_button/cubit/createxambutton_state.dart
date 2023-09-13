part of 'createxambutton_cubit.dart';

@immutable
sealed class CreatExamButtonState {
  final bool canGoNext;

  const CreatExamButtonState(this.canGoNext);
}

final class CreatExamButtonInitial extends CreatExamButtonState {
  const CreatExamButtonInitial(super.canGoNext);
}

final class GetExamButtonState extends CreatExamButtonState {
  const GetExamButtonState(super.canGoNext);
}
