import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../pages/home_page.dart';
import 'firebase_options.dart';
import 'ember_quest/ember_quest.dart';

void main() async {
  // Initialisez Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game App',
      /*'AGW APP' */
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameAndHomePage(),
    );
  }
}

class GameAndHomePage extends StatelessWidget {
  const GameAndHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GameWidget<EmberQuestGame>.controlled(
            gameFactory: () => EmberQuestGame(),
          ),
        ),
        Positioned.fill(
          child: HomePage(),
        ),
      ],
    );
  }
}
