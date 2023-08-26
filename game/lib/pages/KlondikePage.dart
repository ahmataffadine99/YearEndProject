import 'package:flutter/material.dart';
import 'package:game/klondike/klondike_game.dart';
import 'package:flame/game.dart';

class KlondikePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solitaire'),
      ),
      body: GameWidget(game: KlondikeGame()), // Utilisez le jeu Solitaire ici
    );
  }
}
