part of 'calender_cubit.dart';

@immutable
sealed class CalenderState {}

final class CalenderInitial extends CalenderState {}

final class GetCalenderState extends CalenderState {
  Map<DateTime, List<String>> events;
  GetCalenderState(this.events);
}

final class insertCalenderState extends CalenderState {}
