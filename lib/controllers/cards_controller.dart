import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcgarchive/models/cardsmyl_model.dart';
import 'package:tcgarchive/models/cardsopcg_model.dart';
import 'package:tcgarchive/models/cardspkmntcg_model.dart';


class CardsController{

  final _db = FirebaseFirestore.instance;

  Future<List<CardspkmntcgModel>> getPkmCards() async {

    final snapshot = await _db.collection("cardsPkmntcg").get();
    
    snapshot.docs.forEach((doc) {
      print(doc.data());
    });

    final pkmCards = snapshot.docs.map((e) => CardspkmntcgModel.fromSnapshot(e)).toList();
    print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
    
    return pkmCards; 
  }

  Future<List<CardsopcgModel>> getOpcgCards() async {

    final snapshot = await _db.collection("cardsOpcg").get();

    final opcgCards = snapshot.docs.map((e) => CardsopcgModel.fromSnapshot(e)).toList();
    
    
    return opcgCards; 
  }

  Future<List<CardsmylModel>> getMylCards() async {

    final snapshot = await _db.collection("cardsMyl").get();

    final mylCards = snapshot.docs.map((e) => CardsmylModel.fromSnapshot(e)).toList();
    
    
    return mylCards; 
  }
}