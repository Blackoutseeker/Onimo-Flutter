import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:cryptography_flutter/cryptography_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';

import './controllers/stores/session.dart';
import './controllers/services/session_manager.dart';
import './models/themes/default_theme.dart';
import './views/screens/rooms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();

  FlutterCryptography();
  await Hive.initFlutter();

  final GetIt getIt = GetIt.I;
  getIt.registerLazySingleton<SessionStore>(() => SessionStore());

  await SessionManager.initialize();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF111111),
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onimo',
      theme: DefaultTheme.themeData,
      home: RoomsScreen(),
    );
  }
}
