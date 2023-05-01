import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';
import 'package:weather_manager/pages/add_event.dart';
import 'package:weather_manager/pages/firebase_options.dart';
import 'package:weather_manager/pages/home.dart';
import 'package:weather_manager/pages/info_event.dart';
import 'package:weather_manager/pages/authorization.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/home',
      routes: {
        '/authorize': (context) => const Home(),
        '/addEvent': (context) => AddEvent(
              currentDate: DateTime.now(),
            ),
        '/info': (context) => const ShowInfo(),
        '/home': (context) => AuthorizationPage(
            title: 'Авторизация', database: FirebaseFirestore.instance),
      },
    );
  }
}
