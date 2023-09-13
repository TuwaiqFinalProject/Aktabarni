import 'package:final_project/components/button/button.dart';
import 'package:final_project/components/general/glass_card_widget.dart';
import 'package:final_project/components/text/text_field_widget.dart';
import 'package:final_project/components/text/text_widget.dart';
import 'package:final_project/cubit/calender/calender_cubit.dart';
import 'package:final_project/services/database/exams_queries.dart';
import 'package:final_project/utils/constants/colors.dart';
import 'package:final_project/utils/constants/spaces.dart';
import 'package:final_project/utils/extension/nav.dart';
import 'package:final_project/utils/extension/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final today = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  late final ValueNotifier<List<String>> _selectedEvents;

  Map<DateTime, List<String>> events = {};
  final TextEditingController _eventController = TextEditingController();

  getAllEvents() async {
    events = await SupabaseService().GetEvents();
  }

  @override
  void initState() {
    super.initState();
    getAllEvents();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<String> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // context.read<CalenderCubit>().GetCalender();
    return Scaffold(
      backgroundColor: ETheme.colors.backgroundColor,
      body: Center(
        child: GlassCard(
          width: context.getWidth - 30,
          height: context.getHeight - 30,
          child: Column(
            children: [
              kVSpace16,
              Row(
                children: [
                  kHSpace16,
                  InkWell(
                    onTap: () {
                      context.popNav();
                    },
                    child: Icon(
                      Icons.arrow_circle_left_outlined,
                      color: ETheme.colors.primary,
                      size: 30,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  kVSpace32,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                        text: "TableCalendar",
                        fontFamily: 'Tajawal',
                        color: ETheme.colors.primary,
                        size: 18,
                        isBold: true,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  scrollable: true,
                                  // title: TextWidget(text: "Add reminder"),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextFieldWidget(
                                      hint: "add your note",
                                      lable: "Reminder",
                                      controller: _eventController,
                                    ),
                                  ),
                                  actions: [
                                    BlocBuilder<CalenderCubit, CalenderState>(
                                      builder: (context, state) {
                                        return Center(
                                          child: Button(
                                            btnHigth: 40,
                                            text: "Submit",
                                            color: ETheme.colors.white,
                                            backgroundColor:
                                                ETheme.colors.primary,
                                            onPress: () async {
                                              events.putIfAbsent(
                                                  _selectedDay!, () => []);
                                              events[_selectedDay]!.addAll(
                                                  [_eventController.text]);
                                              // TODO:
                                              context
                                                  .read<CalenderCubit>()
                                                  .insertCalender(events);
                                              _eventController.text = "";
                                              context.popNav();
                                              _selectedEvents.value =
                                                  _getEventsForDay(
                                                      _selectedDay!);

                                              setState(() {});
                                            },
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 18,
                              color: ETheme.colors.second,
                            ),
                            kHSpace8,
                            TextWidget(
                              text: 'Add  Events',
                              fontFamily: 'Tajawal',
                              color: ETheme.colors.primary,
                              size: 18,
                              isBold: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  TableCalendar<String>(
                    firstDay: DateTime.now(),
                    lastDay:
                        DateTime(today.year + 1, today.month, today.day - 1),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    calendarFormat: _calendarFormat,
                    eventLoader: _getEventsForDay, // ?
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    onDaySelected: _onDaySelected,
                    calendarStyle: const CalendarStyle(
                      outsideDaysVisible: false,
                    ),
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<String>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: ETheme.colors.primary),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                              onTap: () {},
                              title: Text(value[index]),
                              trailing: IconButton(
                                  onPressed: () async {
                                    events[_selectedDay]!.removeAt(index);
                                    await SupabaseService().updateEvent(events);
                                    // events[_selectedDay]!.removeAt(index);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.delete))),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
