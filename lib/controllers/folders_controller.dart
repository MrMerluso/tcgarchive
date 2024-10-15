
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcgarchive/models/cardsmyl_model.dart';
import 'package:tcgarchive/models/cardsopcg_model.dart';
import 'package:tcgarchive/models/cardspkmntcg_model.dart';
import 'package:tcgarchive/models/folders_model.dart';

class FoldersController {
  
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
 
  Future<List<FoldersModel>> getFoldersFromUser() async {

    DocumentReference userRef = _db.collection("users").doc(_auth.currentUser?.uid);

    final snapshot = await _db
      .collection("cardFolders")
      .where("Creador", isEqualTo: userRef)
      .get();
    
    final userFolders = snapshot.docs.map((doc) => FoldersModel.fromSnapshot(doc)).toList();
    return userFolders;
  }

  Future<FoldersModel> createFolder(String folderName, String tcg) async {

    String createdBy = _auth.currentUser!.uid;
    DocumentReference userRef = _db.collection("users").doc(createdBy);

    DocumentReference doc = _db.collection("cardFolders").doc();

    FoldersModel folder = FoldersModel(
      id: doc.id,
      folderName: folderName, 
      createdBy: userRef, 
      tcg: tcg,
      cards: List<Map<String, dynamic>>.empty(),
    );


    await doc.set(folder.toFirestore());

    return folder;
  }

  Future<FoldersModel> getFolderById(String id) async{
    print("JAJAJAJAJAJAJAJAJAJAJAJAJAJAJAJAJAJAJAJAJAJAJAJAJ");
    print(id.trim());
    final folderSnapshot = await _db.collection("cardFolders").doc(id.trim()).get();
    return FoldersModel.fromSnapshot(folderSnapshot);
  }


  Future<void> addCardToFolder(String cardId, String folderId, int ammount, int price) async{
    if (_auth.currentUser == null) {
      print("no hay usuario autenticado");
      return;
    }

    DocumentReference userRef = _db.collection("users").doc(_auth.currentUser?.uid);

    DocumentReference folderRef = _db.collection("cardFolders").doc(folderId);

    DocumentSnapshot folderSnapshot = await folderRef.get();

    // final creador = folderSnapshot["Creador"];

    if (folderSnapshot.exists && folderSnapshot["Creador"] == userRef){
      
      DocumentReference cardRef = _db.collection("cardsPkmntcg").doc(cardId);

      await folderRef.collection("Cartas").add({
        "Carta": cardRef,
        "Precio": price,
        "Cantidad": ammount,
      });
    }
  }

  Future<List<Map<String, dynamic>>> getCardsFromFolder(String folderId) async{
    if (_auth.currentUser == null) {
      print("no hay usuario autenticado");
      return List.empty();
    }

    final querySnapshot = await _db.collection("cardFolders").doc(folderId).collection("Cartas").get();
    
    final folderDoc = await _db.collection("cardFolders").doc(folderId).get();
    String folderTcg = folderDoc.data()?["Tcg"];

    final cardRefs = querySnapshot.docs.map((doc) => CardInFolder.fromSnapshot(doc)).toList();

    print("ALKÑDSJFGLÑKJASJDÑHGAJNA{LSDJFPUIQEA{OIGJA{ON<HB{ÓIHRGE}[>aNO{E+HGN}{+<OIEHNRG}]}}}");
    print(cardRefs);
    
    List<Map<String, dynamic>> cards = List.empty(growable: true);

    // fixme: esto es una forma terrible de hacer esto, pero sirve por ahora
    switch (folderTcg) {
      case "cardsPkmntcg":
        
        for (var card in cardRefs) {
          final cardSnap = await card.card.get();
          CardspkmntcgModel pkmcard = CardspkmntcgModel.fromSnapshot(cardSnap);            
          cards.add({
            "Carta": pkmcard,
            "Precio": card.precio,
            "Cantidad": card.cantidad,
          });
        }

        break;
      case "cardsMyl":
        
        for (var card in cardRefs) {
          final cardSnap = await card.card.get();
          CardsmylModel mylCard = CardsmylModel.fromSnapshot(cardSnap);            
          cards.add({
            "Carta": mylCard,
            "Precio": card.precio,
            "Cantidad": card.cantidad,
          });
        }

        break;
      case "cardsOpcg":
        
        for (var card in cardRefs) {
          final cardSnap = await card.card.get();
          CardsopcgModel opcgCard = CardsopcgModel.fromSnapshot(cardSnap);            
          cards.add({
            "Carta": opcgCard,
            "Precio": card.precio,
            "Cantidad": card.cantidad,
          });
        }

        break;
      default:
        print("algo ha salido catastroficamente mal");
    }
    
    print(cards);

    return cards;
  }

  Future<void> updateCardInFolder(String cardId, String folderId, int ammount) async{
    
    final folderRef = _db.collection("cardFolders").doc(folderId);

    final folderSnap = await folderRef.get();
    final tcg = folderSnap.data()?["Tcg"];

    DocumentReference cardRef = _db.collection(tcg).doc(cardId);

    final cardInFolder = await folderRef
      .collection("Cartas")
      .where("Carta", isEqualTo: cardRef)
      .get();
    
    for (var card in cardInFolder.docs) {
      await card.reference.update({
        "Cantidad": ammount,
      });
    }
  }

  Future<void> deleteCardInFolder(String cardId, String folderId) async{
    
    final folderRef = _db.collection("cardFolders").doc(folderId);

    final folderSnap = await folderRef.get();
    final tcg = folderSnap.data()?["Tcg"];

    DocumentReference cardRef = _db.collection(tcg).doc(cardId);

    final cardInFolder = await folderRef
      .collection("Cartas")
      .where("Carta", isEqualTo: cardRef)
      .get();

    for (var card in cardInFolder.docs) {
      await card.reference.delete();
    }
  }

}