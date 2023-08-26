import 'package:flutter/material.dart';
import '../pages/authentication_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AGW App'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to your game App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthenticationPage()),
                );
                // Action à effectuer lorsque le bouton est appuyé
              },
              style: ElevatedButton.styleFrom(
                primary:
                    Colors.deepPurple, // Modifier la couleur du bouton aussi
                onPrimary: Colors.white,
              ),
              child: const Text('S\'authentifier'),
            ),
          ],
        ),
      ),
    );
  }
}
