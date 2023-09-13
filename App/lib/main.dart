import 'package:final_project/providers/list_providers.dart';
import 'package:final_project/screens/splash_screen.dart';
import 'package:final_project/services/database/config.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await databaseConfig();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialBlocProvidersList(
      home: SplashPage(),
    );
  }
}
