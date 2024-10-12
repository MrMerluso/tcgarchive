import 'package:cloud_firestore/cloud_firestore.dart';
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
}