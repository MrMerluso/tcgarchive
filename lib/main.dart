import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tcgarchive/controllers/cards_controller.dart';
import 'package:tcgarchive/controllers/folders_controller.dart';
import 'package:tcgarchive/firebase_options.dart';
import 'package:tcgarchive/controllers/user_controller.dart';
import 'package:tcgarchive/models/user_model.dart';

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
    
    final UserController _userController = UserController();
    final FoldersController _foldersController = FoldersController();
    final UserModel user = UserModel(
      usernName: "mrmerluso",
      email: "mrmerluso@hotmail.com",
    );
    // _userController.createUserInFirestore(user, "password");

    _userController.loginWithUsername("mrmerluso", "password");

    // _foldersController.createFolder("Carpeta1", "pkmn");

    List<String> cards = List.from(["JBWaheB0DjCLCKqLiRhZ", "SVqKzyFkJNMMjtPAeEkG"]);
    // _foldersController.addCardsToFolder(cards, "iRsZN1ZERBP4VJyUZMN5");
    // _foldersController.addCardToFolder("JBWaheB0DjCLCKqLiRhZ", "iRsZN1ZERBP4VJyUZMN5", 4);
    _foldersController.getCardsFromFolder("iRsZN1ZERBP4VJyUZMN5");

    final CardsController _cardsController = CardsController();
    // _cardsController.getPkmCards();

    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
