import 'package:final_project/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseData {
  static final client = Supabase.instance.client;
  static final currentUserId = client.auth.currentSession?.user.id;
  static final currentUserEmail = client.auth.currentSession?.user.email;

  Future<UserApp>? getUserName({required userId}) async {
    final supabase = Supabase.instance.client;
    final rawData = await supabase.from('user').select().eq('user_id', userId);
    final List<UserApp> users = [];
    for (final user in rawData) {
      users.add(UserApp.fromJson(user));
    }
    if (users.isNotEmpty) {
      return users.first;
    }

    return UserApp();
  }
}
