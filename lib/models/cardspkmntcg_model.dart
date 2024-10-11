import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CardspkmntcgModel {
  
  final String? id;
  final String cardName;
  final String cardText;
  final String? evolvedFrom;
  final String enegyType;
  final String cardType;
  final String cardRarity;
  final String cardExpansion;
  final String imageUrl;

  const CardspkmntcgModel({
    this.id,
    required this.cardName,
    required this.cardText,
    this.evolvedFrom,
    required this.enegyType,
    required this.cardType,
    required this.cardRarity,
    required this.cardExpansion,
    required this.imageUrl,
  });

  toJson(){
    return{
      "Nombre": cardName,
      "Texto": cardText,
      "Evolucion": evolvedFrom,
      "Energia": enegyType,
      "Tipo": cardType,
      "Rareza": cardRarity,
      "Expansion": cardExpansion,
      "Imagen": imageUrl,
    };
  }

  factory CardspkmntcgModel.fromSnapshot(DocumentSnapshot doc){
    Map<String, dynamic>  data = doc.data() as Map<String, dynamic>;
    return CardspkmntcgModel(
      id: doc.id,
      cardName: data["Nombre"], 
      cardText: data["Evolucion"], 
      enegyType: data["Evolucion"], 
      cardType: data["Tipo"], 
      cardRarity: data["Rareza"], 
      cardExpansion: data["Expansion"], 
      imageUrl: data["Imagen"],
    );
  }

}