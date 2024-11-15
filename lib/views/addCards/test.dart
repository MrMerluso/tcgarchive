import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  final String folderName; // Nombre de la carpeta
  List<Map<String, dynamic>> cards; // Lista de cartas de la db
  final String tcg;
  final String? folderId;
  //final FoldersController _foldersController = FoldersController();

  MyDialog({super.key, required this.folderName, required this.cards, required this.tcg, required this.folderId});

  final List<String> energyTypes = [
    'Grass', 'Fire', 'Water', 'Lightning', 'Psychic', 'Darkness', 'Metal', 'Dragon', 'Fairy', 'Fighting', 'Colorless'
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


  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
                  insetPadding: EdgeInsets.zero, // Elimina el padding predeterminado
                  child:
                   Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        AppBar(
                          title: Text('Filtrar Cartas'),
                          automaticallyImplyLeading: false,
                          leading: 
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                            color: Colors.black,
                          ),
                
                        ),
                Expanded(
                  child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
              widget.tcg == 'cardsOpcg'
            ? [
                _buildFilterSection('Colors', widget.colorsOp, widget.selectedColors),
                //_buildFilterSection('Card Type', widget.cardTypeOpcg, widget.selectedTypeOpcg),
                //_buildFilterSection('Illustration Type', widget.illustraationTypeOpcg, widget.selectedIllustraTypeOpcg),
                //_buildFilterSection('Expansions', widget.expansionsOpcg, widget.selectedExpansionsOpcg),              
              ]
            : widget.tcg == 'cardsPkmntcg'
            ? [
                _buildFilterSection('Energy Types', widget.energyTypes, widget.selectedEnergyTypes),
                //_buildFilterSection('Evolution Stage', widget.evolved, widget.selectedEvolved),
                //_buildFilterSection('Card Type', widget.cardTypePkmn, widget.selectedTypePkmn),
                //_buildFilterSection('Rarity', widget.raritiesPkmn, widget.selectedRaritiesPkmn),
                //_buildFilterSection('Expansions', widget.expansionsPkmn, widget.selectedExpansionsPkmn),
                  ]
            : widget.tcg == 'cardsMyl'
              ?[
                _buildFilterSection('Tipo de Carta', widget.cardTypeMyl, widget.selectedTypeMyl),
                //_buildFilterSection('Rareza', widget.raritiesMyl, widget.selectedRaritiesMyl),
                //_buildFilterSection('Raza', widget.raceMyl, widget.selectedRaceMyl),
                //_buildFilterSection('Expansiones', widget.expansionsMyl, widget.selectedExpansionsMyl),
                //_buildFilterSection('Costo', widget.cost, widget.selectedCost),
              ]
            : [],
          
          
        ),
      ),
    )
                ),
              ],
            ),
          ), //container
        );
  }

  Widget _buildFilterSection(String title, List<String> options, List<String> selected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8.0,
          children: options.map((option) {
            return FilterChip(
              label: Text(option),
              selected: selected.contains(option),
              backgroundColor: Colors.blue,
              selectedColor: Colors.red,
              onSelected: (bool value) {
                setState(() {
                  if (value) {
                    selected.add(option);
                  } else {
                    selected.remove(option);
                  }
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejemplo de Dialogo')),
      body: Center(
        child: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return MyDialog(
                  tcg: 'cardsPkmntcg', // Ejemplo de valor
                  folderId: 'cards',
                  folderName: 'Carpeta',
                  cards: [], // Ejemplo de valor
                );
              },
            );
          },
          icon: Icon(Icons.filter_alt),
          color: Color(0xFF104E75),
          iconSize: 30,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: MyHomePage()));
}

