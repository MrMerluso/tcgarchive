import 'package:cloud_firestore/cloud_firestore.dart';

class FoldersModel {
  
  final String? id;
  final String folderName;
  final String createdBy;
  final String tcg;
  final List<String>? cards;
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