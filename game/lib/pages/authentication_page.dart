import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import '../pages/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/hello_page.dart';
import '../pages/google_login_page.dart';
import '../pages/github_login_page.dart';
import '../pages/login/my_textfield.dart';
import '../pages/login/my_button.dart';
import '../pages/login/square_tile.dart';

class AuthenticationPage extends StatelessWidget {
  AuthenticationPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Ajout d'une clé pour le formulaire

  final String googleLogoUrl =
      'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg';
  final String githubLogoUrl =
      'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png';

  void _navigateToRegistrationPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationPage()),
    );
  }
//Authentification par mail password

  void _signInWithEmailAndPassword(BuildContext context) async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      // Vérification de la validation du formulaire
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Afficher le SnackBar avec le message de réussite
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Connexion réussie'),
          ),
        );

        // Navigate to another page if you want
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HelloPage()),
        );
      } catch (e) {
        // Handle login error
        print(e);

        /* ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );*/
      }
    }
  }

//Authentification par google

  void _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleLoginPage googleLoginPage = GoogleLoginPage();
      await googleLoginPage.signInWithGoogle(context);

      // Vérifier si l'authentification avec Google a réussi
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HelloPage()),
        );
      } else {
        // Gérer l'erreur d'authentification
        print('L\'authentification avec Google a échoué.');
      }
    } catch (e) {
      // Gérer les autres erreurs
      print(e);
    }
  }

//Authentification github
  void _signInWithGithub(BuildContext context) async {
    try {
      final GithubLoginPage githubLoginPage =
          GithubLoginPage(); // Créez une instance de GithubLoginPage
      await githubLoginPage.signInWithGithub(context);
      // Appelez la méthode signInWithGithub de GithubLoginPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HelloPage()),
      );
    } catch (e) {
      // Gestion des erreurs d'authentification
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Authentication'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  Image.asset(
                    'assets/images/lock_icon.png',
                    width: 70,
                    height: 70,
                  ),

                  const SizedBox(height: 50),

                  // welcome back, you've been missed!
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // username textfield
                  MyTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton(
                    onTap: () {
                      _signInWithEmailAndPassword(context);
                    },
                  ),

                  const SizedBox(height: 50),

                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // google + github sign in buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      SquareTile(imagePath: 'assets/images/google.png'),

                      SizedBox(width: 25),

                      // github button
                      SquareTile(imagePath: 'assets/images/github_icon.png'),
                    ],
                  ),

                  // ... autres widgets ...

                  // not a member? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          _navigateToRegistrationPage(context);
                        },
                        child: Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
































































//ancienne version d'affichage de la page login
 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Authentication'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Center(
                child: Form(
                  // Ajout du widget Form
                  key: _formKey, // Utilisation de la clé du formulaire
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un email';
                                  }
                                  // Expression régulière pour valider le format de l'email avec le domaine spécifique
                                  final emailRegex = RegExp(
                                      r'^[a-zA-Z0-9._-]+@(gmail\.com|yahoo\.fr)$');

                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Veuillez entrer une adresse e-mail valide';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Veuillez entrer un mot de passe';
                                  }
                                  if (value.length < 8) {
                                    return 'Le mot de passe doit contenir au moins 8 caractères.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple),
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _signInWithEmailAndPassword(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          primary: Colors.deepPurple,
                          onPrimary: Colors.white,
                        ),
                        child: const Text('Sign In'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Action for SignIn with Google
                          _signInWithGoogle(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          primary: Colors.red,
                          onPrimary: Colors.white,
                        ),
                        icon: SvgPicture.network(
                          googleLogoUrl,
                          height: 24.0,
                          semanticsLabel: 'Google Logo',
                        ),
                        label: const Text('Sign In with Google'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Action for SignIn with GitHub
                          _signInWithGithub(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          primary: Colors.black,
                          onPrimary: Colors.white,
                        ),
                        icon: Image.network(
                          githubLogoUrl,
                          height: 24.0,
                        ),
                        label: const Text('Sign In with GitHub',
                            style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          _navigateToRegistrationPage(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                          primary: Colors.deepPurple,
                          onPrimary: Colors.white,
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }*/

