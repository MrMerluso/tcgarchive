
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcgarchive/models/folders_model.dart';

class FoldersController {
  
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
 
  Future<List<FoldersModel>> getFoldersFromUser() async {

    final snapshot = await _db
      .collection("cardFolders")
      .where("Creador", isEqualTo: _auth.currentUser?.uid)
      .get();
    
    final userFolders = snapshot.docs.map((doc) => FoldersModel.fromSnapshot(doc)).toList();
    return userFolders;
  }

  Future<void> createFolder(String folderName, String tcg) async {

    String createdBy = _auth.currentUser!.uid;
    DocumentReference userRef = _db.collection("users").doc(createdBy);

    FoldersModel folder = FoldersModel(
      folderName: folderName, 
      createdBy: userRef, 
      tcg: tcg,
      cards: List.empty(),
    );

    await _db.collection("cardFolders").add(folder.toFirestore());
  }

  Future<FoldersModel> getFolderById(String id) async{

    final folderSnapshot = await _db.collection("cardFolders").doc(id).get();
    return FoldersModel.fromSnapshot(folderSnapshot);
  }

/*   // ACTUALIZAR LA CANTIDAD DE CARTAS SI ESTA YA ESTA EN LA LISTA
  Future<void> addCardToFolder1(String cardId, String folderId, int ammount) async{

    if (_auth.currentUser == null) {
      print("no hay usuario autenticado");
      return;
    }

    DocumentReference userRef = _db.collection("users").doc(_auth.currentUser?.uid);

    DocumentReference folderRef = _db.collection("cardFolders").doc(folderId);

    DocumentSnapshot folderSnapshot = await folderRef.get();

    final creador = folderSnapshot["Creador"];

    if (folderSnapshot.exists && folderSnapshot["Creador"] == userRef) {

      DocumentReference cardRef = _db.collection("cardsPkmntcg").doc(cardId);
      


      await folderRef.update({
        "Cartas": FieldValue.arrayUnion([{
          "Carta": cardRef,
          "Cantidad": ammount,
        }]),
      });
    
    } else {
      print("No se ha podido añadir la lista de cartas");
    }

  } */

  Future<void> addCardToFolder(String cardId, String folderId, int ammount) async{
    if (_auth.currentUser == null) {
      print("no hay usuario autenticado");
      return;
    }

    DocumentReference userRef = _db.collection("users").doc(_auth.currentUser?.uid);

    DocumentReference folderRef = _db.collection("cardFolders").doc(folderId);

    DocumentSnapshot folderSnapshot = await folderRef.get();

    final creador = folderSnapshot["Creador"];

    if (folderSnapshot.exists && folderSnapshot["Creador"] == userRef){
      
      DocumentReference cardRef = _db.collection("cardsPkmntcg").doc(cardId);

      await folderRef.collection("Cartas").add({
        "Carta": cardRef,
        "Cantidad": ammount,
      });
    }
  }

  Future<void> getCardsFromFolder(String folderId) async{
    if (_auth.currentUser == null) {
      print("no hay usuario autenticado");
      return;
    }

    final querySnapshot = await _db.collection("cardFolders").doc(folderId).collection("Cartas").get();

    final cards = querySnapshot.docs.map((doc) => CardInFolder.fromSnapshot(doc)).toList();

    print("ALKÑDSJFGLÑKJASJDÑHGAJNA{LSDJFPUIQEA{OIGJA{ON<HB{ÓIHRGE}[>aNO{E+HGN}{+<OIEHNRG}]}}}");
    print(cards[0].cantidad);
    
  }

  Future<void> updateCardInFolder(String cardId, String folderId, int ammount) async{
    
  }

  // Future<void> addCardsToFolder(List<String> cardIDs, String folderId) async {

  //   if (_auth.currentUser == null) {
  //     print("no hay usuario autenticado");
  //     return;
  //   }

  //   DocumentReference userRef = _db.collection("users").doc(_auth.currentUser?.uid);

  //   DocumentReference folderRef = _db.collection("cardFolders").doc(folderId);

  //   DocumentSnapshot folderSnapshot = await folderRef.get();

  //   final creador = folderSnapshot["Creador"];

  //   print("Creador de la carpeta: $creador");
  //   print("Usuario $userRef");
    
  //   if (folderSnapshot.exists && folderSnapshot["Creador"] == userRef) {

  //     List<DocumentReference> cardRefs = List.empty(growable: true);
  //     for (var card in cardIDs) {
  //       DocumentReference cardRef = _db.collection("cardsPkmntcg").doc(card);
  //       cardRefs.add(cardRef);
  //     }

  //     await folderRef.update({
  //       "Cartas": FieldValue.arrayUnion(cardRefs),
  //     });
    
  //   } else {
  //     print("No se ha podido añadir la lista de cartas");
  //   }
  // }
}