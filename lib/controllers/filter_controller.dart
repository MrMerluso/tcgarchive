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
Future<List<Map<String, dynamic>>> getFilteredPkmnCards(
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
  
  // Apply filter for Evolucion if selected
  if (selectedEvolved.isNotEmpty) {
    query = query.where('Evolucion', whereIn: selectedEvolved);
    print("Applying filter for Evolucion: $selectedEvolved");
  } else {
    print("No filter applied for Evolucion.");
  }

  // Apply filter for Tipo (Type) if selected
  if (selectedTypePkmn.isNotEmpty) {
    query = query.where('Tipo', whereIn: selectedTypePkmn);
    print("Applying filter for Tipo (Type): $selectedTypePkmn");
  } else {
    print("No filter applied for Tipo.");
  }

  // Apply filter for Rareza (Rarity) if selected
  if (selectedRaritiesPkmn.isNotEmpty) {
    query = query.where('Rareza', whereIn: selectedRaritiesPkmn);
    print("Applying filter for Rareza (Rarity): $selectedRaritiesPkmn");
  } else {
    print("No filter applied for Rareza.");
  }

  // Apply filter for Expansion if selected
  if (selectedExpansionsPkmn.isNotEmpty) {
    query = query.where('Expansion', whereIn: selectedExpansionsPkmn);
    print("Applying filter for Expansion: $selectedExpansionsPkmn");
  } else {
    print("No filter applied for Expansion.");
  }

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

Future<List<Map<String, dynamic>>> getFilteredOpcgCards(
  String tcg,
  List<String> selectedColor,
  List<String> selectedTypeOpcg,
  List<String> selectedIllustraTypeOpcg,
  List<String> selectedExpansionsOpcg,
) async {
  // Start building the query for Firestore
  Query query = FirebaseFirestore.instance.collection('cardsOpcg');

  // Debug: Print the selectedColor
  print("Selected Colors: $selectedColor");

  // Apply filter for Color if selected
  if (selectedColor.isNotEmpty) {
    query = query.where('Color', whereIn: selectedColor);
    print("Applying filter for Color: $selectedColor");
  } else {
    print("No filter applied for Color.");
  }

  // Apply filter for Type if selected
  if (selectedTypeOpcg.isNotEmpty) {
    query = query.where('Tipo', whereIn: selectedTypeOpcg);
    print("Applying filter for Type: $selectedTypeOpcg");
  } else {
    print("No filter applied for Type.");
  }

  // Apply filter for Illustrator Type if selected
  if (selectedIllustraTypeOpcg.isNotEmpty) {
    query = query.where('Ilustracion', whereIn: selectedIllustraTypeOpcg);
    print("Applying filter for Illustrator Type: $selectedIllustraTypeOpcg");
  } else {
    print("No filter applied for Illustrator Type.");
  }

  // Apply filter for Expansion if selected
  if (selectedExpansionsOpcg.isNotEmpty) {
    query = query.where('Expansion', whereIn: selectedExpansionsOpcg);
    print("Applying filter for Expansion: $selectedExpansionsOpcg");
  } else {
    print("No filter applied for Expansion.");
  }

  // Get the results
  QuerySnapshot snapshot = await query.get();
  
  // Debug: Check the size of the results
  print("Number of documents returned: ${snapshot.docs.length}");

  // Convert DocumentSnapshots to Map objects
  List<Map<String, dynamic>> filteredCards = snapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id; // Add document ID for reference
    return data;
  }).toList();
  print("Filtered cards: $filteredCards");
  return filteredCards;
}

Future<List<Map<String, dynamic>>> getFilteredMylCards(
  String tcg,
  List<String> selectedTypeMyl,
  List<String> selectedRaritiesMyl,
  List<String> selectedRaceMyl,
  List<String> selectedExpansionsMyl,
  List<String> selectedCost,
  List<String> selectedAttack,
) async {
  // Start building the query for Firestore
  Query query = FirebaseFirestore.instance.collection('cardsMyl');

  // Apply filter for Type if selected
  if (selectedTypeMyl.isNotEmpty) {
    query = query.where('Tipo', whereIn: selectedTypeMyl);
    print("Applying filter for Type: $selectedTypeMyl");
  } else {
    print("No filter applied for Type.");
  }

  // Apply filter for Rarity if selected
  if (selectedRaritiesMyl.isNotEmpty) {
    query = query.where('Frecuencia', whereIn: selectedRaritiesMyl);
    print("Applying filter for Rarity: $selectedRaritiesMyl");
  } else {
    print("No filter applied for Rarity.");
  }

  // Apply
  if (selectedRaceMyl.isNotEmpty) {
    query = query.where('Raza', whereIn: selectedRaceMyl);
    print("Applying filter for Raza: $selectedRaceMyl");
  } else {
    print("No filter applied for Raza.");
  }

  // Apply filter for Expansion if selected
  if (selectedExpansionsMyl.isNotEmpty) {
    query = query.where('Expansion', whereIn: selectedExpansionsMyl);
    print("Applying filter for Expansion: $selectedExpansionsMyl");
  } else {
    print("No filter applied for Expansion.");
  }

  if (selectedCost.isNotEmpty) {
    query = query.where('Coste', whereIn: selectedCost);
    print("Applying filter for Cost: $selectedCost");
  } else {
    print("No filter applied for Cost.");
  }

  if (selectedAttack.isNotEmpty) {
    query = query.where('Fuerza', whereIn: selectedAttack);
    print("Applying filter for Attack: $selectedAttack");
  } else {
    print("No filter applied for Attack.");
  }

  // Get the results
  QuerySnapshot snapshot = await query.get();
  
  // Debug: Check the size of the results
  print("Number of documents returned: ${snapshot.docs.length}");

  // Convert DocumentSnapshots to Map objects
  List<Map<String, dynamic>> filteredCards = snapshot.docs.map((doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id; // Add document ID for reference
    return data;
  }).toList();
  print("Filtered cards: $filteredCards");
  return filteredCards;
}
}