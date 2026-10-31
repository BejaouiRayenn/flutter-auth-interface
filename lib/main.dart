 
//  on a realiser l importation  des  composants visuels de Flutter mil materiel .dart ili nalkaw fiha   les  button wl icon ...
// material.dart twafrelna des composants prets bich nistamlohom kimaa ElevatedButton wala  AlertDialog..
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
/* main() : point d’entrée de toute application 
runApp() istamlneha bich namlou lexecution de lapplication et flutter yarrref widget de debut 
 MyApp widget principale de notre application .*/ 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  /* claas MyApp herite de StatelessWidget khater maanech memorisation de memoire de letat kima mathalan theme wnom de lapplication mnisthakouch nbdlouhom 
  hnee tji lutilite mtaa StatelessWidget */
  @override
  // redefinition mtaa methode 
  Widget build(BuildContext context)
   { // Build contexte taati li flutter lemplacement mtaa widget 
    return MaterialApp(
      // material app tmathel configuration general de notre application 
      debugShowCheckedModeBanner: false,
      //
      title: 'Authentification',
      // nom de lapplication 
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // theme de notre application 
      ),
            home: const LoginScreen(),
    );//awel page de notrre application ili hiya page dauthentification
  }
}

class LoginScreen extends StatefulWidget {
  // claas loginscreen herite de statefulwidget khater iil besoin bich yamil memorisation lil etat ù
  //login change depend ce lutilisateur hnee lutilite du statefullwidget
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  //hnee amlna creation state du page khater les donnes modifiables ytbdlou 
  //loginscreenstate privee mnjmouch nistamlouh lbara min main dart
}

class _LoginScreenState extends State<LoginScreen> {
  // Contrôll  des champs
  final TextEditingController _emailController =
      TextEditingController();
      // controller njmouch nbdlou une fois creer 
      // texteditingcontroller widget de flutter tthakem fi textfield
      //istamlneh bich namlou recuperation lil emsil mtaa utilisateur 

  final TextEditingController _passwordController =
      TextEditingController();
      //texteditingcontroller bich naamlou recuperation lil mot de passe 
      bool _isLoading = false;
      //pas de chargement des donnees au debut baaed nbadlouha true lors de saisie  des informations 
      // Identifiants corrects pour tester la connexion.
      //chainne e caractere pour conmparaison avec ce qui est ecrit par lutilisateur
   final String correctEmail = 'rayen@gmail.com';
   final String correctPassword = '12345678';

  // Méthode appelée lorsque l'utilisateur clique sur le bouton
  /*TextEditingController  permet de lire et modifier le contenu d’un TextField
final la référence au contrôleur ne change pas 
*/


void _handleLogin() {
  // method thabet mil informatin ili dakhalhoum utilisateur 
  // Récupérer les informations saisies
  String email = _emailController.text.trim();
  //enlever les espaces 
  String password = _passwordController.text;

  // Vérifier si les champs sont vides
  if (email.isEmpty || password.isEmpty) {
    _showErrorDialog('Veuillez remplir tous les champs');
    return;
  }

  // Vérifier le format de l'email.
  if (!RegExp(r'^[\w.-]+@([\w-]+\.)+[\w-]{2,}$')
  // regular expression nistamlouha bich nhadidiu formast mouaayen kima email 
      .hasMatch(email))
      //bich nchoufou kn mail kima regular expression 
       {
    _showErrorDialog('Veuillez entrer un email valide');
    return;
  }

  // Vérifier la longueur du mot de passe mae 8 caracteres
  if (password.length > 8) {
    _showErrorDialog(
      'Le mot de passe ne doit pas dépasser 8 caractères',
    );
    return;
  }

  // Comparer les identifiants saisis avec les identifiants prédéfinis
  //kn email w mdp galtin affichage erreur 
  if (email != correctEmail || password != correctPassword) {
    _showErrorDialog('Email ou mot de passe incorrect');
    return;
  }

  // demarrer le chargement après une authentification correcte.

  // bbad ki nkmlou nthabtou mil les champs state nbdlouha true bich yssir chargement mtaa donnnes 
  setState(() {
    _isLoading = true;
  });

  // Simuler le traitement de la connexion pendant 2 secondes
  //baaed mnkmlou nthabtou mil les donnes w state mteana true ysir chargement de 2 secondes 
  
  Future.delayed(const Duration(seconds: 2), () {
    if (!mounted) return;
    //kmounted tchouf kn widget mazal wl lee mithel nokhroj mil page d authentification knal mykmlou 2 seconde
    // waktHa state mteana nbdlouha false wmaach ana chargement des donnees wnwakfou chargement 

    setState(() {
      _isLoading = false;
    });
// fil cas lokhra kn widget mazal mawjoud naamlou affichage ili authentification taadeet 
    
    _showSuccessDialog();
  });
}
// en caS que lutilisateur ne remplis pas les champs ou champs fausses wl widget maach mawjoud detriut
//aaffichage du message derreur 
void _showErrorDialog(String message) {
  // istamalna string message bich meme fenetre tkharjina des erreur mokhtalfin 
  //yaani pas oblige koul erreur namlou fenetre wahdou 
  //mthln ki mnmrouch champ yjina rempòir les champs wl en cas de email incorrecte il nous affiche un erreur concernant email 
  showDialog(
    //aaficher message
    context: context,
    //lemplacement mtaa message 
    builder: (BuildContext dialogContext)
     {//fonction bich tmmlina contexte mtaa fenetre a travers buuilder 
      return AlertDialog(
        // fenetre nlkaw fiha message derreur contexte mtaa erreur w des bouton kima ok mathaln
        title: const Text('Erreur'),
        // hnee titre mtaa fenetre 
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },// ki ninzlou mithel aal ok wl ay boton tjina fil fenetre ki ninzlou aa l bouton ttsaker fenetre
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
// en cas les donnes sont corrects wt widget mawjoud 
//afficher message succes 
void _showSuccessDialog() {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Succès'),
        content: Text(
          'Connexion réussie ! Bienvenue '
          '${_emailController.text.trim()}',
        ),// hnee amlna concatenation d un variable ili houwa mail avec message 
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              // ki ninzlou a lbouton ok ttnaha fenetre 
              // wnarjou page initiale wtfaskhou email wmdp ili f text Field

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
      // scaffold houwa ynadhem body de nitre app 
      backgroundColor: Colors.grey[100],
      //colour du back ground 
      body: SafeArea(
        // safe area nistmlouha pour eviter les composant de nottre app
        child: Padding(
          // les espages des cotes 
          padding: const EdgeInsets.all(24.0),
          // paading de 24 pixels de quatres cotes 
          child: Column(
            // organiser les section de haut vers le bas 
            mainAxisAlignment: MainAxisAlignment.center,
            //organisation des sections 
            children: [
              // children fiha widget ili bich tjina f page kima les textes w les botons ...
              const Text(
                // css de texte
                'Connexion',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                // llabel mtaa email 
                controller: _emailController,
                // relie le text field par controllerb 
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'entrez@votre.email',
                  // exemple dans label 
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              TextField(
                // label du mdp 
                    controller: _passwordController,
                    //relie le label avec controller 
                     obscureText: true,
                     // il naffiche pas les caracteres mais plutot des point cest securite 
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
      // kn login shih donc circular progressindicator 
      // si non elevatedbutton 
        onPressed: _handleLogin,
        // ki ninzlou al button cest que fonction handlelogin va realiser 
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
// pour la buttion de creation du compte pas encore devellope 
              TextButton(
                onPressed: () {
                  // si lutilisateur nzel al crer un compte yjina message temporaire fih fonctionalite dinscription a venir 
                  //whesha yssie a travers show snack bar 
                  //scaffoldmessenger houwa mas2oul ala snack bar 
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
  // quand  widget detruuit 
  // on va liberer la memoire utiliser par  supprimer  les controlleurs de lemail et mdp 
  //pour eviter fuiite memoire 
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
 
}
