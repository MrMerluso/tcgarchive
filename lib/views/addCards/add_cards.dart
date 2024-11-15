// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tcgarchive/controllers/filter_controller.dart';
import 'package:tcgarchive/controllers/folders_controller.dart';
import 'package:tcgarchive/models/cardsmyl_model.dart';
import 'package:tcgarchive/models/cardsopcg_model.dart';
import 'package:tcgarchive/models/cardspkmntcg_model.dart';
import 'package:tcgarchive/controllers/filter_controller.dart';

class AddCards extends StatefulWidget {
  
  final String folderName; // Nombre de la carpeta
  List<Map<String, dynamic>> cards; // Lista de cartas de la db
  final String tcg;
  final String? folderId;
  final FoldersController _foldersController = FoldersController();

  AddCards({super.key, required this.folderName, required this.cards, required this.tcg, required this.folderId});


  @override
  _AddCardsState createState() => _AddCardsState();
}

/*class MyDialog extends StatefulWidget {
  final List<String> energyTypes = [
    'Grass', 'Fire', 'Water', 'Lightning', 'Psychic', 'Darkness', 'Metal', 'Dragon', 'Fighting', 'Colorless'
  ];
  final List<String> selectedEnergyTypes = [];

  final List<String> evolved = [
    'Basic', 'Stage 1', 'Stage 2', 'Pokemon V', 'Pokemon VSTAR'
  ];
  final List<String> selectedEvolved = [];

  final List<String> cardTypePkmn = [
    'Pokemon', 'Trainer Item', 'Energy'
  ];
  final List<String> selectedTypePkmn = [];

  final List<String> raritiesPkmn = [
    'Common', 'Uncommon', 'Rare', 'Rare Holo','Rare Holo EX', 'Rare Holo GX','Rare Holo Lv.X', 'LEGEND', 'Ultra Rare', 'Rare Prime', 'Double Rare',
    'ACE SPEC rare','Rare BREAK','Promo', 'Illustration Rare', 'Shiny Ultra Rare', 'Hyper Rare', 'Amazing', 'Radiant Rare', 'Special Illustration Rare','Shiny Rare'
  ];
  final List<String> selectedRaritiesPkmn = [];

  final List<String> expansionsPkmn = [
    'Stellar Crown', 'Shrouded Fable', 'Twilight Masquerade', 
  ];
  final List<String> selectedExpansionsPkmn = [];

  //filters opcg

  final List<String> colorsOp = [ 
    'Black', 'Blue', 'Red', 'Green', 'Yellow', 'Purple', 'Multicolor'
  ];
  final List<String> selectedColors = [];

  final List<String> cardTypeOpcg = [
    'Leader', 'Character', 'Event', 'Stage'
  ];
  final List<String> selectedTypeOpcg = [];

  final List<String> illustraationTypeOpcg = [
    'Comic', 'Animation', 'Original Illustrations', 'Other'
  ];
  final List<String> selectedIllustraTypeOpcg = [];

  final List<String> expansionsOpcg = [
    'OP-05', 'ST-18'
  ];
  final List<String> selectedExpansionsOpcg = [];

  // fitlers myl
  final List<String> cardTypeMyl = [
     'Aliado', 'Talismán', 'Arma', 'Tótem', 'Oro'
  ];
  final List<String> selectedTypeMyl = [];

  final List<String> raritiesMyl = [
    'Vasallo', 'Cortesano', 'Real', 'Mega Real', 'Ultra Real','Legendaria', 'Promo'
  ];
  final List<String> selectedRaritiesMyl = [];

  final List<String> raceMyl = [
    'Dragón', 'Faerie', 'Caballero', 'Sacerdote', 'Eterno', 'Faraón', 
    'Desafiante', 'Defensor', 'Sombra', 'Titán', 'Olímpico', 'Héroe'
  ];
  final List<String> selectedRaceMyl = [];

  final List<String> expansionsMyl = [
    'Espada Sagrada', 'Dominios de Ra', 'Hijos de Daana', 'Helénica' 
  ];
  final List<String> selectedExpansionsMyl = [];

  final List<String> cost = [
    '0', '1', '2', '3', '4', '5', '6'
  ];
  final List<String> selectedCost = [];

  final List<String> attack = [
    '0', '1', '2', '3', '4', '5', '6',
  ];
  final List<String> selectedAttack = [];

  final String tcg;

  MyDialog({super.key,required this.tcg});


  @override
  _MyDialogState createState() => _MyDialogState();
}*/
class MyDialog extends StatefulWidget {
  final List<String> energyTypes = [
    'Grass', 'Fire', 'Water', 'Lightning', 'Psychic', 'Darkness', 'Metal', 'Dragon', 'Fighting', 'Colorless'
  ];
  final List<String> selectedEnergyTypes = [];

  final List<String> evolved = [
    'Basic', 'Stage 1', 'Stage 2', 'Pokemon V', 'Pokemon VSTAR'
  ];
  final List<String> selectedEvolved = [];

  final List<String> cardTypePkmn = [
    'Pokemon', 'Trainer Item', 'Energy'
  ];
  final List<String> selectedTypePkmn = [];

  final List<String> raritiesPkmn = [
    'Common', 'Uncommon', 'Rare', 'Rare Holo','Rare Holo EX', 'Rare Holo GX','Rare Holo Lv.X', 'LEGEND', 'Ultra Rare', 'Rare Prime', 'Double Rare',
    'ACE SPEC rare','Rare BREAK','Promo', 'Illustration Rare', 'Shiny Ultra Rare', 'Hyper Rare', 'Amazing', 'Radiant Rare', 'Special Illustration Rare','Shiny Rare'
  ];
  final List<String> selectedRaritiesPkmn = [];

  final List<String> expansionsPkmn = [
    'Stellar Crown', 'Shrouded Fable', 'Twilight Masquerade', 
  ];
  final List<String> selectedExpansionsPkmn = [];

  final String tcg;

  MyDialog({super.key, required this.tcg});

  @override
  _MyDialogState createState() => _MyDialogState();
}




/*class _MyDialogState extends State<MyDialog> {
   final FilterController _filterController = FilterController();
  
  // Reset function stays the same

void _applyFilters() async {
  print("Selected Pkmn: ${widget.selectedTypePkmn}");
  print("Selected Energy Type: ${widget.selectedEnergyTypes}");
  print("Selected Evolved: ${widget.selectedEvolved}");
  // Add other filter values similarly

  // Now apply the filter
  List<DocumentSnapshot> filteredCards = await _filterController.getFilteredCards(
    widget.tcg,
    widget.selectedColors,
    widget.selectedTypeOpcg,
    widget.selectedIllustraTypeOpcg,
    widget.selectedExpansionsOpcg,
    widget.selectedEnergyTypes,
    widget.selectedEvolved,
    widget.selectedTypePkmn,
    widget.selectedRaritiesPkmn,
    widget.selectedExpansionsPkmn,
    widget.selectedTypeMyl,
    widget.selectedRaritiesMyl,
    widget.selectedRaceMyl,
    widget.selectedExpansionsMyl,
    widget.selectedCost,
    widget.selectedAttack,
  );

  // Check if the filteredCards is correct
  print("Filtered Cards: $filteredCards");

  // Close the dialog and return the filtered data
  Navigator.pop(context, filteredCards);
}

Widget _buildFilterChip(String filterText, List<String> selectedList) {
  final isSelected = selectedList.contains(filterText);
  return FilterChip(
    label: Text(
      filterText,
      style: TextStyle(
        color: isSelected ? Color(0xFFEBEEF2) : Colors.black,
      ),
    ),
    checkmarkColor: Color(0xFFEBEEF2),
    selected: isSelected,
    backgroundColor: Colors.grey[200],
    selectedColor: Color(0xFF6194E2),
    onSelected: (bool selected) {
      setState(() {
        if (selected) {
          selectedList.add(filterText);
        } else {
          selectedList.remove(filterText);
        }
      });
    },
  );
}

   Widget _buildFilterSection(String title, List<String> items, List<String> selectedList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8, // Espacio horizontal entre chips
          runSpacing: 8, // Espacio vertical entre filas de chips
          children: items.map((item) => _buildFilterChip(item, selectedList)).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _resetFiters(String tcg){
    setState(() {
    switch (tcg) {
      case 'cardsOpcg':
        widget.selectedColors.clear();
        widget.selectedTypeOpcg.clear();
        widget.selectedIllustraTypeOpcg.clear();
        widget.selectedExpansionsOpcg.clear();
        break;
      case 'cardsMyl':
      widget.selectedTypeMyl.clear();
      widget.selectedRaritiesMyl.clear();
      widget.selectedRaceMyl.clear();
      widget.selectedExpansionsMyl.clear();
      widget.selectedCost.clear();
      break;
      case 'cardsPkmntcg':
      widget.selectedEnergyTypes.clear();
      widget.selectedEvolved.clear();
      widget.selectedTypePkmn.clear();
      widget.selectedRaritiesPkmn.clear();
      widget.selectedExpansionsPkmn.clear();
      break;
  }
      
  });

  }*/
 
 class _MyDialogState extends State<MyDialog> {
  final FilterController _filterController = FilterController();

  // Apply Filters Method - Modify it to integrate with your Pokémon-specific query
void _applyFilters() async {
  print("Selected Pkmn: ${widget.selectedTypePkmn}");
  print("Selected Energy Type: ${widget.selectedEnergyTypes}");
  print("Selected Evolved: ${widget.selectedEvolved}");
  
  // Now apply the filter
  List<Map<String, dynamic>> filteredCards = await _filterController.getFilteredCards(
    widget.tcg,
    widget.selectedEnergyTypes,
    widget.selectedEvolved,
    widget.selectedTypePkmn,
    widget.selectedRaritiesPkmn,
    widget.selectedExpansionsPkmn,
  );
  
  // Check if the filteredCards is correct
  print("Filtered Cards: $filteredCards");

  // Close the dialog and return the filtered data

  Navigator.pop(context, filteredCards);
}

  // Build Filter Chips (doesn't change)
  Widget _buildFilterChip(String filterText, List<String> selectedList) {
    final isSelected = selectedList.contains(filterText);
    return FilterChip(
      label: Text(
        filterText,
        style: TextStyle(
          color: isSelected ? Color(0xFFEBEEF2) : Colors.black,
        ),
      ),
      checkmarkColor: Color(0xFFEBEEF2),
      selected: isSelected,
      backgroundColor: Colors.grey[200],
      selectedColor: Color(0xFF6194E2),
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            selectedList.add(filterText);
          } else {
            selectedList.remove(filterText);
          }
        });
      },
    );
  }

  // Build Filter Section (doesn't change)
  Widget _buildFilterSection(String title, List<String> items, List<String> selectedList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8, // Horizontal spacing between chips
          runSpacing: 8, // Vertical spacing between rows of chips
          children: items.map((item) => _buildFilterChip(item, selectedList)).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  // Reset Filters
  void _resetFiters(String tcg) {
    setState(() {
      switch (tcg) {
        case 'cardsOpcg':
          widget.selectedEnergyTypes.clear();
          widget.selectedEvolved.clear();
          widget.selectedTypePkmn.clear();
          widget.selectedRaritiesPkmn.clear();
          widget.selectedExpansionsPkmn.clear();
          break;
        case 'cardsPkmntcg':
          widget.selectedEnergyTypes.clear();
          widget.selectedEvolved.clear();
          widget.selectedTypePkmn.clear();
          widget.selectedRaritiesPkmn.clear();
          widget.selectedExpansionsPkmn.clear();
          break;
        default:
          break;
      }
    });
  }
 
 /*@override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            AppBar(
              title: Text('Filtrar Cartas'),
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
                color: Colors.black,
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    onPressed: () {
                      _resetFiters(widget.tcg);
                    },
                    child: Text('Reset', style: TextStyle(color: Color(0xFF104E75), fontSize: 17)),
                  ),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: widget.tcg == 'cardsOpcg'
                        ? [
                            _buildFilterSection('Colors', widget.colorsOp, widget.selectedColors),
                            _buildFilterSection('Card Type', widget.cardTypeOpcg, widget.selectedTypeOpcg),
                            _buildFilterSection('Illustration Type', widget.illustraationTypeOpcg, widget.selectedIllustraTypeOpcg),
                            _buildFilterSection('Expansions', widget.expansionsOpcg, widget.selectedExpansionsOpcg),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: _applyFilters,  // Apply filters and close dialog
                                  label: Text('Buscar', style: TextStyle(color: Color(0xFFEBEEF2))),
                                  icon: Icon(Icons.search, color: Color(0xFFEBEEF2)),
                                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF104E75)),
                                ),
                              ],
                            )
                          ]
                        : widget.tcg == 'cardsPkmntcg'
                            ? [
                                _buildFilterSection('Energy Types', widget.energyTypes, widget.selectedEnergyTypes),
                                _buildFilterSection('Evolution Stage', widget.evolved, widget.selectedEvolved),
                                _buildFilterSection('Card Type', widget.cardTypePkmn, widget.selectedTypePkmn),
                                _buildFilterSection('Rarity', widget.raritiesPkmn, widget.selectedRaritiesPkmn),
                                _buildFilterSection('Expansions', widget.expansionsPkmn, widget.selectedExpansionsPkmn),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: _applyFilters,  // Apply filters and close dialog
                                      label: Text('Buscar', style: TextStyle(color: Color(0xFFEBEEF2))),
                                      icon: Icon(Icons.search, color: Color(0xFFEBEEF2)),
                                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF104E75)),
                                    ),
                                  ],
                                )
                              ]
                            : widget.tcg == 'cardsMyl'
                                ? [
                                    _buildFilterSection('Tipo de Carta', widget.cardTypeMyl, widget.selectedTypeMyl),
                                    _buildFilterSection('Rareza', widget.raritiesMyl, widget.selectedRaritiesMyl),
                                    _buildFilterSection('Raza', widget.raceMyl, widget.selectedRaceMyl),
                                    _buildFilterSection('Expansiones', widget.expansionsMyl, widget.selectedExpansionsMyl),
                                    _buildFilterSection('Costo', widget.cost, widget.selectedCost),
                                    _buildFilterSection('Fuerza', widget.attack, widget.selectedAttack),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: _applyFilters,  // Apply filters and close dialog
                                          label: Text('Buscar', style: TextStyle(color: Color(0xFFEBEEF2))),
                                          icon: Icon(Icons.search, color: Color(0xFFEBEEF2)),
                                          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF104E75)),
                                        ),
                                      ],
                                    ),
                                  ]
                                : [],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

 @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            AppBar(
              title: Text('Filtrar Cartas'),
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
                color: Colors.black,
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    onPressed: () {
                      _resetFiters(widget.tcg);
                    },
                    child: Text('Reset', style: TextStyle(color: Color(0xFF104E75), fontSize: 17)),
                  ),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: widget.tcg == 'cardsPkmntcg'
                        ? [
                            _buildFilterSection('Energy Types', widget.energyTypes, widget.selectedEnergyTypes),
                            _buildFilterSection('Evolution Stage', widget.evolved, widget.selectedEvolved),
                            _buildFilterSection('Card Type', widget.cardTypePkmn, widget.selectedTypePkmn),
                            _buildFilterSection('Rarity', widget.raritiesPkmn, widget.selectedRaritiesPkmn),
                            _buildFilterSection('Expansions', widget.expansionsPkmn, widget.selectedExpansionsPkmn),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: _applyFilters,  // Apply filters and close dialog
                                  label: Text('Buscar', style: TextStyle(color: Color(0xFFEBEEF2))),
                                  icon: Icon(Icons.search, color: Color(0xFFEBEEF2)),
                                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF104E75)),
                                ),
                              ],
                            )
                          ]
                        : [], // You can add more cases for other TCGs here
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddCardsState extends State<AddCards> {

  List<Map<String, dynamic>> availableCards = [];

  String searchQuery = ''; // Búsqueda de cartas
  bool _isLoading = true;
  

  List<Map<String, dynamic>> get filteredCards {
    if (searchQuery.isEmpty) {
      return widget.cards; // Mostrar todas las cartas si no hay búsqueda
    }

    return widget.cards.where((card) {
      return card['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  set cards (List<Map<String, dynamic>> value) {
    setState(() {
      widget.cards = value;
    });
  }


  Future<void> _fetchCards() async{
    try {
      FilterController filterController = FilterController();
      List<Map<String, dynamic>> fetchedCards = await filterController.fetchAllCards(tcgType: widget.tcg);
      print("cards fetched: $fetchedCards");
      setState(() {
        availableCards = fetchedCards;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
        print('Error fetching cards: $e');
    }
    //setState(() {
     //_isLoading = true;
     //});
     //try {{
     // final cards = await _filterController.fetchAllCards(tcgType: widget.tcg);
     //}
    

    List<Map<String, dynamic>> cardsFromFolder = await widget._foldersController.getCardsFromFolder(widget.folderId!);

    List<Map<String, dynamic>> newCards = [];

    for (var card in cardsFromFolder) {
      switch (widget.tcg) {
        case "cardsPkmntcg":
          
          CardspkmntcgModel pkmcard = card["Carta"];       
          Map<String, dynamic> pkmcardDetails = pkmcard.toFirestore();
          pkmcardDetails.addAll({
            'name': pkmcard.cardName,
            'id': card["idInFolder"],
            'copies': card["Cantidad"],
            'price': card["Precio"],
          });

          newCards.add(pkmcardDetails);

          break;

        case "cardsOpcg":
          
          CardsopcgModel opcgcard = card["Carta"];
          Map<String, dynamic> opcgcardDetails = opcgcard.toFirestore();
          opcgcardDetails.addAll({
            'name': opcgcard.cardName,
            'id': card["idInFolder"],
            'copies': card["Cantidad"],
            'price': card["Precio"],
          });
          newCards.add(opcgcardDetails);
                  
          break;

        case "cardsMyl":
          
          CardsmylModel mylcard = card["Carta"];
          Map<String, dynamic> mylcardDetails = mylcard.toFirestore();
          mylcardDetails.addAll({
            'id': card["idInFolder"],
            'name': mylcard.cardName,
            'copies': card["Cantidad"],
            'price': card["Precio"],
          });
          newCards.add(mylcardDetails);

          break;
        
        default:
          print("doudoudoudoudoudoudoudoudoudoudoudou");
      }

    }
    setState(() {
      _isLoading = false;
    });
  }

Future<void> _searchCards(String query) async {
  try {
    String collectionName = widget.tcg; // Use the correct TCG collection

    if (query.isEmpty) {
      // Fetch all cards if the search bar is empty
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .get();

      setState(() {
        availableCards = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return data;
        }).toList();
      });
      return;
    }

    // Fetch all cards and filter locally
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(collectionName)
        .get();

    setState(() {
      availableCards = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).where((card) {
        final cardName = card['Nombre'].toString().toLowerCase();
        return cardName.contains(query.toLowerCase());
      }).toList();
    });
  } catch (e) {
    print("Error searching cards: $e");
  }
}


  void _addCardtoFolder() async {
    final Map<String, dynamic>? newCard = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController cardNameController = TextEditingController();
        final TextEditingController cardCopiesController = TextEditingController();
        final TextEditingController cardPriceController = TextEditingController();

        return AlertDialog(
          title: Text('Agregar Nueva Carta'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cardNameController,
                decoration: InputDecoration(hintText: 'Nombre de la carta'),
              ),
              TextField(
                controller: cardCopiesController,
                decoration: InputDecoration(hintText: 'Cantidad de copias'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: cardPriceController,
                decoration: InputDecoration(hintText: 'Precio de la carta'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar sin nada
              },
            ),
            TextButton(
              child: Text('Agregar'),
              onPressed: () {
                String name = cardNameController.text;
                int copies = int.tryParse(cardCopiesController.text) ?? 0;
                double price = double.tryParse(cardPriceController.text) ?? 0.0;
                if (name.isNotEmpty && copies > 0) {
                  Navigator.of(context).pop({'name': name, 'copies': copies, 'price': price}); // Pasar datos de la carta
                }
              },
            ),
          ],
        );
      },
    );

    if (newCard != null) {
      setState(() {
        widget.cards.add(newCard); // Agregar nueva carta a la lista
      });
    }
  }

  // Función para mostrar la imagen en grande con opciones de editar o eliminar
  void _showCardDetail(BuildContext context, int index) {
    final card = widget.cards[index];
    final TextEditingController cardPriceController = TextEditingController(text: card['price'].toString());
    final TextEditingController cardCopiesController = TextEditingController(text: card['copies'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(card['name'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop(); // Cerrar el diálogo
                        // Aquí podrías abrir un diálogo para editar el nombre de la carta
                        },
                      ),
                    ],
                  ),
                  // Aquí mostrarías la imagen grande de la carta
                  Container(
                    height: 500, // Tamaño de la imagen ampliada
                    color: Colors.grey[300], // Placeholder de la imagen
                    child: Image.network(
                      card['Imagen'], // Imagen de la carta
                      fit: BoxFit.cover,
                    )
                  ),
                  SizedBox(height: 20),
                  // Campos para editar el precio y las copias con etiquetas
                  Row(
                    children: [
                      Expanded(child: Text('Precio:')),
                      Expanded(
                        child: TextField(
                          controller: cardPriceController,
                          decoration: InputDecoration(hintText: 'Precio de la carta'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Incremento/Decremento de la cantidad de copias
                  Row(
                    children: [
                      Expanded(child: Text('Cantidad:')),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            int currentCopies = int.tryParse(cardCopiesController.text) ?? 0;
                            if (currentCopies > 0) {
                              cardCopiesController.text = (currentCopies - 1).toString();
                            }
                          });
                        },
                      ),
                      Container(
                        width: 50, // Ancho del campo de texto para la cantidad
                        child: TextField(
                          controller: cardCopiesController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center, // Centramos el número
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            int currentCopies = int.tryParse(cardCopiesController.text) ?? 0;
                            cardCopiesController.text = (currentCopies + 1).toString();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                        onPressed: () {

                          showDialog(
                            context: context, 
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text('Eliminar ${card['name']}'),
                                content: RichText(text: TextSpan(
                                  text: 'La carta se borrará permanentemente de esta carpeta y tendrás que agregarla nuevamente, ¿Estás seguro de eliminar ',
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(text: '${card['name']}?', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ]
                                )),
                                actions: [
                                  TextButton(
                                    child: Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Cerrar el diálogo
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Eliminar'),
                                    onPressed: () {
                                      setState(() {
                                        widget.cards.removeAt(index);
                                      });
                                      FoldersController().deleteCardInFolder(card["id"], widget.folderId!);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          margin: EdgeInsets.only(
                                            bottom: 10.0, // Ajusta este valor para la distancia deseada del FAB
                                            left: 16.0,
                                            right: 16.0,
                                          ),
                                          duration: Duration(milliseconds: 1500),
                                          content: Text('Carta eliminada', style: TextStyle(color: Colors.white)),
                                          backgroundColor: Colors.red,
                                        ),
                                      ); // Eliminar la carta
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop(); // Cerrar el diálogo
                                    },
                                  ),
                                ],
                              );
                            });
                          //Navigator.of(context).pop(); // Cerrar el diálogo
                        },
                      ),
                      TextButton(
                        child: Text('Guardar'),
                        onPressed: () {
                          setState(() {

                            widget.cards[index]['price'] = int.tryParse(cardPriceController.text) ?? 0.0;
                            widget.cards[index]['copies'] = int.tryParse(cardCopiesController.text) ?? 0;
                            FoldersController().updateCardInFolder(card["id"], widget.folderId!, card["copies"], card["price"]);
                          });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                  bottom: 10.0, // Ajusta este valor para la distancia deseada del FAB
                                  left: 16.0,
                                  right: 16.0,
                                ),
                                duration: Duration(milliseconds: 1500),
                                content: Text('Cambios guardados', style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.green,
                              ),
                            );
                          Navigator.of(context).pop(); // Guardar cambios y cerrar el diálogo
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        );
      },
    );


  }

  String _titleName(String tcg){
    switch (tcg) {
      case "cardsPkmntcg":
        return 'Cartas Pokémon TCG';
      case "cardsOpcg":
        return 'One Piece Card Game';
      case "cardsMyl":
        return 'Cartas Mitos y Leyendas';
      default:
        return 'Cartas';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color:  Color(0xFFEBEEF2)),
        centerTitle: true,
        title: Text(_titleName(widget.tcg), style: const TextStyle(color: Color(0xFFEBEEF2), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF104E75), // Color del encabezado
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(16.0),
            child:
           Row(
              children:[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                  hintText: 'Buscar carta...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Color(0xFF0000000))),
                ),
                onChanged: (query) {
                    _searchCards(query); // Actualizar la búsqueda
                },
            ),
          ),
          SizedBox(width: 5),
          Container(
             height: 55.0,
                width: 55.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 1.0, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignInside),
                  borderRadius: BorderRadius.circular(8.0),
                ),
            child:
            IconButton(onPressed: (){
              showDialog(
                context: context,
                builder: (BuildContext context) {
                return MyDialog(
                  tcg: widget.tcg,
                ); //aqui dialogo
      },
    );
            }, icon: Icon(Icons.filter_alt), color: Color(0xFF104E75), iconSize: 30),
            
          ),
              
              
        ],))
          ,
          _isLoading ? 
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Cargando tus cartas...'),
                ],
              ),
            )
          ) 
          :
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6, // Proporción más rectangular
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                //itemCount: filteredCards.length,
                itemCount: availableCards.length,
                itemBuilder: (context, index) {
                  var card = availableCards[index];
                  //final card = filteredCards[index];
                  return GestureDetector(
                    onTap: () {
                      _showCardDetail(context, index); // Mostrar carta en grande al hacer clic
                    },
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                card['Imagen'], // Imagen de la carta
                                fit: BoxFit.cover,
                              ),
                            ),
                          //card['price'] != 0
                            //? 
                            //Padding(
                                //padding: const EdgeInsets.all(8.0),
                                //child: Text(
                                  //'\$${card['price']}',
                                  //style: TextStyle(fontSize: 16, color: Colors.black),
                                  //),
                                //)
                            //: SizedBox.shrink(),
                        ],
                      ),
                      //Positioned(
                          //bottom: 40,
                          //right: 10,
                          //child: CircleAvatar(
                            //radius: 16,
                            //backgroundColor: Colors.white,
                            //child: Text(
                              //'x${card['copies']}',
                              //style: TextStyle(color: Color(0xFF6194B8), fontSize: 14),
                            //),
                          //),
                        //),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}
