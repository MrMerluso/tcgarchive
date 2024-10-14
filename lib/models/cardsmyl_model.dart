import 'package:cloud_firestore/cloud_firestore.dart';

class CardsmylModel {
  
  final String? id;
  final String cardName;
  final String cardExpansion;
  final String cardType;
  final String cardRace;
  final String cardFrequency;
  final String cardCost;
  final String cardStr;
  final String imageUrl;

  const CardsmylModel({
    this.id,
    required this.cardName,
    required this.cardExpansion,
    required this.cardType,
    required this.cardRace,
    required this.cardFrequency,
    required this.cardCost,
    required this.cardStr,
    required this.imageUrl,
  });

  Map<String, dynamic> toFirestore(){
    return{
      "Nombre": cardName,
      "Expansion": cardExpansion,
      "Tipo": cardType,
      "Raza": cardRace,
      "Frecuencia": cardFrequency,
      "Coste": cardCost,
      "Fuerza": cardStr,
      "Imagen": imageUrl,
    };
  }

  factory CardsmylModel.fromSnapshot(DocumentSnapshot doc){
    Map<String, dynamic>  data = doc.data() as Map<String, dynamic>;
    return CardsmylModel(
      id: doc.id,
      cardName: data["Nombre"], 
      cardExpansion: data["Expansion"],
      cardType: data["Tipo"], 
      cardRace: data["Raza"],
      cardFrequency: data["Frecuencia"],
      cardCost: data["Coste"],
      cardStr: data["Fuerza"],
      imageUrl: data["Imagen"],
    ); 
  }
}