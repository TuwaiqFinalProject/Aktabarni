import 'dart:convert';

import 'package:final_project/models/exam_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final supabase = Supabase.instance.client;
  static final currentUserId = supabase.auth.currentSession!.user.id;

  Future insertExam(Exam exam) async {
    exam.userOwnerId = currentUserId;
    await supabase.from('exam').insert(exam.toJson());
  }

  Future getUserOwnerNameById({required String userOwnerId}) async {
    print(userOwnerId);
    final rawUserNames =
        await supabase.from('user').select('name').eq('user_id', userOwnerId);
    print(rawUserNames);
    return rawUserNames[0]['name'];
  }

  Future getUserExams() async {
    final rawExams =
        await supabase.from('exam').select().eq('user_owner_id', currentUserId);
    List<Exam> exams = [];
    for (var element in rawExams) {
      exams.add(Exam.fromJsonDatabase(element));
    }
    for (var exam in exams) {
      List rawUserOwnerName = await supabase
          .from('user')
          .select('name')
          .eq('user_id', exam.userOwnerId);
      exam.userOwnerName = rawUserOwnerName[0]['name'];
    }
    return exams;
  }

  Future<List<Exam>> getAllExams() async {
    final rawListOfExams =
        await supabase.from('exam').select().eq('isPublic', true);
    List<Exam> exams = [];
    for (var element in rawListOfExams) {
      exams.add(Exam.fromJsonDatabase(element));
    }
    for (var exam in exams) {
      List rawUserOwnerName = await supabase
          .from('user')
          .select('name')
          .eq('user_id', exam.userOwnerId);
      exam.userOwnerName = rawUserOwnerName[0]['name'];
    }
    return exams;
  }

  Future deleteExam(Exam exam) async {
    await supabase.from('exam').delete().eq('id', exam.id);
  }

  Future changeExamPrivacy(Exam exam) async {
    exam.isPublic = !exam.isPublic!;
    await supabase
        .from('exam')
        .update({'isPublic': exam.isPublic}).eq('id', exam.id);
  }

  Future updateEvent(Map<DateTime, List<String>> events) async {
    // convert key form [DateTime] to [String]
    Map<String, List<String>> eventsString = {};
    for (var dateTime in events.keys) {
      eventsString[dateTime.toString()] = events[dateTime]!;
    }

    await supabase.from('user').update(
        {'calender': json.encode(eventsString)}).eq('user_id', currentUserId);
  }

  Future<Map<DateTime, List<String>>> GetEvents() async {
    print("Test 1");
    final eventsString = await supabase
        .from('user')
        .select('calender')
        .eq('user_id', currentUserId)
        .single();

    print("Single $eventsString");

    final calenderJsonString = eventsString['calender'] as String;
    final calenderJson =
        json.decode(calenderJsonString) as Map<String, dynamic>;
    Map<DateTime, List<String>> events = {};

    calenderJson.forEach((key, value) {
      var dateTime = DateTime.parse(key);
      events[dateTime] = List<String>.from(value);
    });
    print("Events: $events");
    print("Events type: ${events.runtimeType}");

    return events;
  }
}
