import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleLoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print('La connexion avec Google a été annulée par l\'utilisateur.');
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print(
          'Google Access Token: ${googleAuth.accessToken}'); // Imprimer le token d'accès Google

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // Utilisez cette credential pour l'authentification avec Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print('Utilisateur connecté : ${userCredential.user!.uid}');

      // Redirigez ou effectuez d'autres actions après l'authentification réussie
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Aucun utilisateur trouvé pour cet email.');
      } else if (e.code == 'wrong-password') {
        print('Mot de passe incorrect.');
      }
    } catch (e, stackTrace) {
      print('Une erreur est survenue lors de la connexion avec Google: $e');
      print('Stack trace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion avec Google'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            signInWithGoogle(context);
          },
          child: Text('Se connecter avec Google'),
        ),
      ),
    );
  }
}
