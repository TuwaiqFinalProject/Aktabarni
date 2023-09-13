import 'dart:async';
import 'package:final_project/screens/auth/login_screen.dart';
import 'package:final_project/screens/navigation_bar_screen.dart';
import 'package:final_project/services/database/user_data.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool canGoHome = false;
  StreamSubscription? listen;

  @override
  void initState() {
    SupabaseData.client.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        canGoHome = true;
        setState(() {});
      }

      if (event == AuthChangeEvent.signedOut) {
        canGoHome = false;
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: canGoHome ? const NavigationBarScreen() : const LoginScreen()),
    );
  }
}
