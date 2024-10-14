import 'package:cloud_firestore/cloud_firestore.dart';

class CardInFolder {
  final String? id;
  final int cantidad;
  final DocumentReference card;

  const CardInFolder({
    this.id,
    required this.cantidad,
    required this.card,
  });

  factory CardInFolder.fromSnapshot(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CardInFolder(
      cantidad: data["Cantidad"], 
      card: data["Carta"]
    );
  }
}

class FoldersModel {
  
  final String? id;
  final String folderName;
  final DocumentReference createdBy;
  final String tcg;
  final List<Map<String, dynamic>>? cards;
  final String? shareCode;

  const FoldersModel({
    this.id,
    required this.folderName,
    required this.createdBy,
    required this.tcg,
    this.cards,
    this.shareCode,
  });

  Map<String, dynamic> toFirestore(){
    return{
      "Nombre": folderName,
      "Creador": createdBy,
      "Tcg": tcg,
      "Cartas": cards,
    };
  }

  factory FoldersModel.fromSnapshot(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return FoldersModel(
      id: doc.id,
      folderName: data["Nombre"], 
      createdBy: data["Creador"],
      tcg: data["Tcg"],
      cards: data["Cartas"],
      shareCode: data["Codigo"],
    ); 
  }
}