import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../ember_quest/ember_quest.dart';
import '../ember_quest/overlays/game_over.dart';
import '../ember_quest/overlays/main_menu.dart';

class EmberQuestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jouer Ember Quest'),
      ),
      body: GameWidget<EmberQuestGame>(
        game: EmberQuestGame(), // Utilisez le constructeur par défaut
        overlayBuilderMap: {
          'MainMenu': (_, game) => MainMenu(game: game),
          'GameOver': (_, game) => GameOver(game: game),
        },
        initialActiveOverlays: const ['MainMenu'],
      ),
    );
  }
}
