import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcgarchive/models/user_model.dart';


class UserController {
  
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Future<void> _createUserWithEmailAndPassword(String email, String password) async {
  //   await _auth.createUserWithEmailAndPassword(email: email, password: password);
  // }

  Future<String> createUserInFirestore(UserModel user, String password) async{

    // / Revisar si existe alguna cuenta con el nombre de usuario
    var userQuery = await _db.collection("users").where("Nombre", isEqualTo: user.usernName).get();
    if (userQuery.docs.isNotEmpty) {
      return "Este nombre de usuario ya existe";
    }

    try {
      await _auth.createUserWithEmailAndPassword(email: user.email, password: password);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case "email-already-in-use":
          message = "Este correo ya está siendo utilizado";
          break;
        case "invalid-email":
          message = "Correo inválido";
          break;
        case "weak-password":
          message = "La contraseña debe tener al menos 6 caracteres";
          break;
        default:
          message = "Ha ocurrido un error, inténtalo de nuevo";
      }
      return message;
    }    
    
    await _db.collection("users").doc(_auth.currentUser?.uid).set(user.toFirestore());
    return "exito";
  }

  Future<bool> loginWithUsername(String username, String password) async{

    final userSnapshot = await _db.collection("users").where("Nombre", isEqualTo: username).get();

    try {
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      await _auth.signInWithEmailAndPassword(
        email: userDoc["Correo"], 
        password: password
      );
    } catch (e) {
      print("error al iniciar sesion");
      return false;
    }
    

    final userId = _auth.currentUser?.email;

    print("el usuario actual es $userId");
    return true;
  }

}