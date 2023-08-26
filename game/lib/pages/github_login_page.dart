import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';

class GithubLoginPage extends StatelessWidget {
  // Remplacez par vos propres informations
  final GitHubSignIn gitHubSignIn = GitHubSignIn(
    clientId: '06e822ed8eb2f6b32b06',
    clientSecret: '331a4a2246f3328e1d62b747a100b07d5761a599',
    redirectUrl: 'https://www.google.com',
  );

  Future<void> signInWithGithub(BuildContext context) async {
    try {
      // Déclencher le flux de connexion
      final result = await gitHubSignIn.signIn(context);
      print(
          'GitHub Access Token: ${result.token}'); // Imprimer le token d'accès GitHub

      if (result.status == GitHubSignInResultStatus.ok) {
        // Créer un credential
        final AuthCredential credential =
            GithubAuthProvider.credential(result.token!);
        // Utilisez cette credential pour l'authentification avec Firebase
        await FirebaseAuth.instance.signInWithCredential(credential);

        // Redirigez ou effectuez d'autres actions après l'authentification réussie
        // ...
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion avec Github'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            signInWithGithub(context);
          },
          child: Text('Se connecter avec Github'),
        ),
      ),
    );
  }
}
