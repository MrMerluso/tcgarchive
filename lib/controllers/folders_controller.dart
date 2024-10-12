
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

  Future<void> createFolder(FoldersModel folder) async {

    final 
  }
}