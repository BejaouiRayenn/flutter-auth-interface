 
// importer les composants visuels de Flutter  Text, Button, Scaffold..
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
/* main() : point d’entrée de toute application 
runApp() : lance l’application et affiche le widget racine MyApp
const : l’objet est créé une seule fois à la compilation  ce qui engendre meilleur performance .*/ 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  /*StatelessWidget : widget sans état car la configuration générale ne change jamais
{super.key} : paramètre nommé qui transmet la clé (Key) au parent*/ 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
/*override : on redéfinit la méthode build du parent
build() retourne l’arbre de widgets 
MaterialApp : widget racine qui configure l’application.
debugShowCheckedModeBanner: false → cache le bandeau « DEBUG ».
title → nom de l’application
theme → thème global 
home → première page affichée */

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
/*pourquoi Stateful ? L’écran change pendant l’utilisation 
createState() crée l’objet State qui garde les données modifiables.
_ signifie que la classe est privée (visible uniquement dans ce fichier).*/ 
class _LoginScreenState extends State<LoginScreen> {
  // Contrôleurs des champs
  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();
      bool _isLoading = false;

  // Méthode appelée lorsque l'utilisateur clique sur le bouton
  /*TextEditingController  permet de lire et modifier le contenu d’un TextField
final la référence au contrôleur ne change pas 
_isLoading  booléen qui indique si la connexion est en cours*/ 

void _handleLogin() {
  String email = _emailController.text.trim();
  String password = _passwordController.text;
  //trim() supprime les espaces au début et à la fin de l’email

  // Vérifier les champs
  if (email.isEmpty || password.isEmpty) {
    _showErrorDialog('Veuillez remplir tous les champs');
    return;
  }

  // Vérifier le format de l'email
  if (!RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,}$')
      .hasMatch(email)) {
    _showErrorDialog('Veuillez entrer un email valide');
    return;
  }
  if (password.length > 8) {
  _showErrorDialog('Le mot de passe ne doit pas dépasser 8 caractères');
  return;
}

/*Décomposition du motif :
^ début de chaîne
[\w.-]+ lettres, chiffres, _, ., - (partie avant le @)
@ le symbole arobase
([\w-]+\.)+ nom de domaine suivi d’un point (ex. gmail.)
[\w-]{2,} extension d’au moins 2 caractères (ex. com)
$ fin de chaîne
! inverse le résultat  on entre dans le if si l’email ne correspond pas.*/ 
  // Démarrer le chargement
  setState(() {
    _isLoading = true;
  });

  // Simuler une connexion pendant 2 secondes
  Future.delayed(const Duration(seconds: 2), () {
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    _showSuccessDialog();
  });
}
/*Future.delayed  exécute le code après 2 secondes 
mounted  indique si le widget est encore affiché  si l’utilisateur a quitté l’écran on évite de modifier un widget détruit 
On désactive le chargement puis on affiche le succès.*/ 
 

void _showErrorDialog(String message) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
/*showDialog  affiche une fenêtre modale par-dessus l’écran
builder :fonction qui construit le contenu du dialogue
AlertDialog  title, content
Navigator.of(dialogContext).pop()  ferme le dialogue.
Le paramètre message rend la méthode réutilisable pour toutes les erreurs
*/ 

void _showSuccessDialog() {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Succès'),
        content: Text(
          'Connexion réussie ! Bienvenue '
          '${_emailController.text.trim()}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();

              _emailController.clear();
              _passwordController.clear();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Connexion',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'entrez@votre.email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              TextField(
                    controller: _passwordController,
                     obscureText: true,
                    maxLength: 8,
                    decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    border: OutlineInputBorder(),
  ),
),

              const SizedBox(height: 30),

              
                
_isLoading
    ? const CircularProgressIndicator()
    : ElevatedButton(
        onPressed: _handleLogin,
        child: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 15,
          ),
          child: Text(
            'Se connecter',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),

              

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Fonctionnalité d’inscription à venir !',
                      ),
                    ),
                  );
                },
                child: const Text('Créer un compte'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  /*Appelée quand l’écran est détruit
   Elle libère la mémoire utilisée par les contrôleurs (évite les fuites mémoire) et super.dispose() appelle la version du parent.*/ 
}
