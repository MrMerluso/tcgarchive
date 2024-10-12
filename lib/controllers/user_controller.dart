import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcgarchive/models/user_model.dart';


class UserController {
  
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> _createUserWithEmailAndPassword(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserInFirestore(UserModel user, String password) async{
    _createUserWithEmailAndPassword(user.email, password);
    
    await _db.collection("users").doc(_auth.currentUser?.uid).set(user.toFirestore());
  }

}