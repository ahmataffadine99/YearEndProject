import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../pages/emberQuestPage.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../pages/KlondikePage.dart';

class HelloPage extends StatefulWidget {
  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeechRecognizer();
  }

  void _initSpeechRecognizer() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isListening = true;
      });
    }
  }

  void _startListening() {
    if (!_isListening) {
      _speech.listen(
        onResult: (result) {
          String recognizedWords =
              result.recognizedWords.toLowerCase().replaceAll(' ', '');
          print("Recognized words: $recognizedWords");

          if (recognizedWords == 'solitaire') {
            _startGame(context, 'klondike');
          } else if (recognizedWords == 'salut') {
            _startGame(context, 'emberQuest');
          }
        },
      );
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Container(
        decoration: BoxDecoration(
            /* image: DecorationImage(
            image: AssetImage(
                "assets/images/github_icon.png"), 
            fit: BoxFit.cover,
          ),*/
            ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                items: [
                  buildGameButton(
                      context, 'Klondike', 'Play Klondike', 'klondike'),
                  buildGameButton(
                      context, 'EmberQuest', 'Play Ember Quest', 'emberQuest'),
                ],
                options: CarouselOptions(
                  height: 200, // Hauteur du carrousel
                  viewportFraction:
                      0.8, // Fraction de l'écran occupée par un élément
                  enableInfiniteScroll: true, // Défilement infini
                  enlargeCenterPage:
                      true, // Mettre en avant l'élément au centre
                  autoPlay: true, // Lecture automatique
                  autoPlayInterval:
                      Duration(seconds: 5), // Intervalle de lecture automatique
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  if (!_isListening) {
                    _startListening();
                  } else {
                    _stopListening();
                  }
                },
                icon: Image.asset(
                  'assets/images/voice_icon.png',
                  width: 20,
                  height: 20,
                ),
                label: Text('Voice Command'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildGameButton(
                    context, 'Klondike', 'Play Klondike', 'klondike'),
                SizedBox(width: 10),
                buildGameButton(
                    context, 'EmberQuest', 'Play Ember Quest', 'emberQuest'),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                if (!_isListening) {
                  _startListening();
                } else {
                  _stopListening();
                }
              },
              icon: Image.asset(
                'assets/images/voice_icon.png',
                width: 20,
                height: 20,
              ),
              label: Text('Voice Command'),
            ),
          ],
        ),
      ),
    );
  }*/

  Widget buildGameButton(BuildContext context, String gameName,
      String buttonText, String command) {
    double buttonSize =
        MediaQuery.of(context).size.width * 0.4; // 40% de la largeur de l'écran

    return ElevatedButton(
      onPressed: () => _startGame(context, command),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius:
              BorderRadius.circular(buttonSize * 0.1), // Arrondi proportionnel
        ),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize:
                    buttonSize * 0.08), // Taille de police proportionnelle
          ),
        ),
      ),
    );
  }

  void _startGame(BuildContext context, String gameCommand) {
    if (gameCommand == 'klondike') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KlondikePage()),
      );
    } else if (gameCommand == 'emberQuest') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmberQuestPage()),
      );
    }
  }
}

/*
class HelloPage extends StatefulWidget {
  @override
  _HelloPageState createState() => _HelloPageState();
}

class _HelloPageState extends State<HelloPage> {
  final List<String> imgList = [
    'assets/images/klondike-sprites.png',
    'assets/images/klondike-sprites.png',
    'assets/images/klondike-sprites.png',
  ];

  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  void _startListening(String game) async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (SpeechRecognitionResult result) {
            String command = result.recognizedWords.toLowerCase();
            print("Recognized command: $command"); // Afficher le vocal
            if (command == 'solitaire' && game == 'solitaire') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => KlondikePage()),
              );
            } else if (command == 'salut' && game == 'salut') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmberQuestPage()),
              );
            }
            _stopListening();
          },
        );
      }
    }
  }

  void _stopListening() {
    if (_isListening) {
      _speech.stop();
      setState(() {
        _isListening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                autoPlay: true,
              ),
              items: imgList
                  .map((item) => Container(
                        child: Center(
                            child: Image.asset(item,
                                fit: BoxFit.cover, width: 1000)),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome! You are logged in.',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KlondikePage()),
                );
              },
              child: Text('Play Klondike'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmberQuestPage()),
                );
              },
              child: Text('Play Ember Quest'),
            ),
            ElevatedButton(
              onPressed: () => _startListening('solitaire'),
              child: Text('Voice "Solitaire"'),
            ),
            ElevatedButton(
              onPressed: () => _startListening('salut'),
              child: Text('Voice "Salut"'),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/*class HelloPage extends StatelessWidget {
  final List<String> imgList = [
    'assets/images/klondike-sprites.png',
    'assets/images/klondike-sprites.png',
    'assets/images/klondike-sprites.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                autoPlay: true, // Activation du défilement automatique
              ),
              items: imgList
                  .map((item) => Container(
                        child: Center(
                            child: Image.asset(item,
                                fit: BoxFit.cover, width: 1000)),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20), // Un peu d'espace
            Text(
              'Welcome! You are logged in.',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text('Solitaire'),
                      ),
                      body: GameWidget(game: KlondikeGame()),
                    ),
                  ),
                );
              },
              child: Text('Jouer au solitaire'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EmberQuestPage(), // Utilisez la nouvelle page
                  ),
                );
              },
              child: Text('Play Ember Quest'),
            )
          ],
        ),
      ),
    );
  }
}



*/








/*import 'package:flutter/material.dart';
import '../klondike_game.dart';
import 'package:flame/game.dart';

class HelloPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome! You are logged in.',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text('Solitaire'),
                      ),
                      body: GameWidget(game: KlondikeGame()),
                    ),
                  ),
                );
              },
              child: Text('Jouer au solitaire'),
            ),
          ],
        ),
      ),
    );
  }
}
*/


