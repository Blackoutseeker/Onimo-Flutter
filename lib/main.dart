import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

import 'package:onimo/models/themes/default_theme.dart';
import 'package:onimo/views/screens/rooms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onimo',
      theme: DefaultTheme.instance.themeData,
      home: const RoomsScreen(userNickname: 'john_doe7'),
      routes: {
        'rooms': (_) => const RoomsScreen(userNickname: 'john_doe7'),
      },
    );
  }
}
