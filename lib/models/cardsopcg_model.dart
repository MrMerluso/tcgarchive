import 'package:cloud_firestore/cloud_firestore.dart';

class CardsopcgModel {
  
  final String? id;
  final String cardName;
  final String cardExpansion;
  final String cardColor;
  final String cardType;
  final String cardIllustration;
  final String imageUrl;

  const CardsopcgModel({
    this.id,
    required this.cardName,
    required this.cardExpansion,
    required this.cardColor,
    required this.cardType,
    required this.cardIllustration,
    required this.imageUrl,
  });

  Map<String, dynamic> toFirestore(){
    return{
      "Nombre":       cardName,
      "Expansion":    cardExpansion,
      "Color":        cardColor,
      "Tipo":         cardType,
      "Ilustracion":  cardIllustration,
      "Imagen": imageUrl
    };
  }

  factory CardsopcgModel.fromSnapshot(DocumentSnapshot doc){
    Map<String, dynamic>  data = doc.data() as Map<String, dynamic>;
    return CardsopcgModel(
      id: doc.id,
      cardName: data["Nombre"], 
      cardExpansion: data["Expansion"],
      cardColor: data["Color"],
      cardType: data["Tipo"], 
      cardIllustration: data["Ilustracion"],
      imageUrl: data["Imagen"],
    ); 
  }
}