import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tcgarchive/carpeta_compartida.dart';

import 'package:tcgarchive/firebase_options.dart';

import 'package:tcgarchive/login.dart';
import 'package:tcgarchive/login_splashscreen.dart';

import 'package:tcgarchive/registration.dart';
import 'package:tcgarchive/views/ventana_carpetas.dart';
import 'package:tcgarchive/views/ventana_cartas.dart';
import 'package:tcgarchive/views/ventana_tcg.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF104E75),
        ),
        scaffoldBackgroundColor: const Color(0xFFEBEEF2),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color(0xFFEBEEF2)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginSplashscreen(),
        '/login': (context) => TCGApp(),
        '/home': (context) => HomeScreen(),
        '/register': (context) => SignUpScreen(),
        '/select-tcg': (context) => SelectTcgScreen(),
        '/cards': (context) => CardScreen(folderName: 'defaultFolder', cards: [], tcg: 'cardsPkmntcg'), // Nueva ruta para la ventana de cartas
        '/shared-folder': (context) => SearchFolder(),
      },
    );

  // @override
  // Widget build(BuildContext context) {
    
  //   final UserController _userController = UserController();
  //   final FoldersController _foldersController = FoldersController();
  //   final UserModel user = UserModel(
  //     usernName: "mrmerluso",
  //     email: "mrmerluso@hotmail.com",
  //   );
  //   // _userController.createUserInFirestore(user, "password");

  //   _userController.loginWithUsername("mrmerluso", "password");

  //   // _foldersController.createFolder("Carpeta1", "pkmn");

  //   List<String> cards = List.from(["JBWaheB0DjCLCKqLiRhZ", "SVqKzyFkJNMMjtPAeEkG"]);
  //   // _foldersController.addCardsToFolder(cards, "iRsZN1ZERBP4VJyUZMN5");
  //   // _foldersController.addCardToFolder("JBWaheB0DjCLCKqLiRhZ", "iRsZN1ZERBP4VJyUZMN5", 4);
  //   _foldersController.getCardsFromFolder("iRsZN1ZERBP4VJyUZMN5");

  //   final CardsController _cardsController = CardsController();
  //   // _cardsController.getPkmCards();

  //   return const MaterialApp(
  //     home: Scaffold(
  //       body: Center(
  //         child: Text('Hello World!'),
  //       ),
  //     ),
  //   );
  }
}
