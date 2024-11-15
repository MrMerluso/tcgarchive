import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tcgarchive/models/cardsmyl_model.dart';
import 'package:tcgarchive/models/cardsopcg_model.dart';
import 'package:tcgarchive/models/cardspkmntcg_model.dart';
import 'package:tcgarchive/models/folders_model.dart';

class FilterController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchAllCards({required String tcgType}) async {
    try {
      // Determine the correct Firestore collection based on TCG type
      String collectionName;
      switch (tcgType) {
        case "cardsPkmntcg":
          collectionName = "cardsPkmntcg"; // Adjust to match your Firestore structure
          break;
        case "cardsOpcg":
          collectionName = "cardsOpcg";
          break;
        case "cardsMyl":
          collectionName = "cardsMyl";
          break;
        default:
          throw Exception("Invalid TCG type: $tcgType");
      }

      // Fetch all cards from the selected collection
      QuerySnapshot snapshot = await _firestore.collection(collectionName).get();

      // Convert the fetched data into a list of maps
      List<Map<String, dynamic>> cards = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add document ID for reference
        return data;
      }).toList();

      return cards;
    } catch (e) {
      print("Error fetching cards: $e");
      return [];
    }
  }
Future<List<Map<String, dynamic>>> getFilteredCards(
  String tcg,
  List<String> selectedEnergyTypes,
  List<String> selectedEvolved,
  List<String> selectedTypePkmn,
  List<String> selectedRaritiesPkmn,
  List<String> selectedExpansionsPkmn,
) async {
  // Start building the query for Firestore
  Query query = FirebaseFirestore.instance.collection('cardsPkmntcg');

  // Debug: Print the selectedEnergyTypes
  print("Selected Energy Types: $selectedEnergyTypes");

  // Apply filter for Energia (energyType) if selected
  if (selectedEnergyTypes.isNotEmpty) {
    query = query.where('Energia', whereIn: selectedEnergyTypes);
    print("Applying filter for Energia (energyType): $selectedEnergyTypes");
  } else {
    print("No filter applied for Energia.");
  }

  // Apply other filters (add as needed)

  // Get the results
  QuerySnapshot snapshot = await query.get();
  
  // Debug: Check the size of the results
  print("Number of documents returned: ${snapshot.docs.length}");

  // Convert DocumentSnapshots to CardspkmntcgModel objects
  List<Map<String, dynamic>> filteredCards = snapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add document ID for reference
        return data;
      }).toList();
      print("Filtered cards: $filteredCards");
      return filteredCards;
}
}
