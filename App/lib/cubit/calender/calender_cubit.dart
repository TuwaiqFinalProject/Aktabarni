import 'package:bloc/bloc.dart';
import 'package:final_project/services/database/exams_queries.dart';
import 'package:meta/meta.dart';

part 'calender_state.dart';

class CalenderCubit extends Cubit<CalenderState> {
  CalenderCubit() : super(CalenderInitial());

  GetCalender() async {
    Map<DateTime, List<String>> events2 = await SupabaseService().GetEvents();
    emit(GetCalenderState(events2));
  }

  insertCalender(Map<DateTime, List<String>> events) async {
    await SupabaseService().updateEvent(events);
    emit(insertCalenderState());
  }
}
