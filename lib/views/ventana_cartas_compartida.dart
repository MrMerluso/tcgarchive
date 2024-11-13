// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:tcgarchive/controllers/folders_controller.dart';
import 'package:tcgarchive/models/cardsmyl_model.dart';
import 'package:tcgarchive/models/cardsopcg_model.dart';
import 'package:tcgarchive/models/cardspkmntcg_model.dart';
import 'package:tcgarchive/models/folders_model.dart';
import 'package:tcgarchive/views/ventana_carpetas.dart';
import 'package:tcgarchive/views/ventana_tcg.dart';

import '../carpeta_compartida.dart';

class SharedFolder extends StatefulWidget {
  // final String folderName; // Nombre de la carpeta
  
  // final String tcg;
  final String folderId;

  SharedFolder({super.key, required this.folderId});

  @override
  _SharedFolderState createState() => _SharedFolderState();
}

class _SharedFolderState extends State<SharedFolder> {
  String searchQuery = ''; // Búsqueda de cartas
  String folderName = '';
  List<Map<String, dynamic>> cards = []; // Lista de cartas para esta carpeta


  FoldersController _foldersController = FoldersController();

  List<Map<String, dynamic>> get filteredCards {
    if (searchQuery.isEmpty) {
      return cards; // Mostrar todas las cartas si no hay búsqueda
    }

    return cards.where((card) {
      return card['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  // set cards (List<Map<String, dynamic>> value) {
  //   setState(() {
  //     cards = value;
  //   });
  // }
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  int index = 1;

  final screens = [
    HomeScreen(),
    SearchFolder(),
    //SelectTcgScreen()
  ];


  Future<void> _fetchCardsFromFolder(String folderId) async{
    
    FoldersModel folder = await _foldersController.getFolderById(folderId.trim());
    String folderTcg = folder.tcg;

    setState(() {
      folderName = folder.folderName;
    });


    List<Map<String, dynamic>> cardsFromFolder = await _foldersController.getCardsFromFolder(folderId.trim());

    List<Map<String, dynamic>> newCards = [];

    for (var card in cardsFromFolder) {
      switch (folderTcg) {
        case "cardsPkmntcg":
          
          CardspkmntcgModel pkmcard = card["Carta"];
          newCards.add({
            'name': pkmcard.cardName,
            'copies': card["Cantidad"],
            'price': card["Precio"]
          });
          break;

        case "cardsOpcg":
          
          CardsopcgModel opcgcard = card["Carta"];
          newCards.add({
            'name': opcgcard.cardName,
            'copies': card["Cantidad"],
            'price': card["Precio"]
          });
          break;

        case "cardsMyl":
          
          CardsmylModel mylcard = card["Carta"];
          newCards.add({
            'name': mylcard.cardName,
            'copies': card["Cantidad"],
            'price': card["Precio"]
          });
          break;
        
        default:
          print("doudoudoudoudoudoudoudoudoudoudoudou");
      }

    }

    setState(() {
      cards = newCards;
    });


  }

  // Función para mostrar la imagen en grande con opciones de editar o eliminar
  void _showCardDetail(BuildContext context, int index) {
    final card = cards[index];
    
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
                    child: Image.asset(
                      'images/zagreus.jpg', // Imagen de la carta
                      fit: BoxFit.cover,
                    )
                  ),
                  SizedBox(height: 20),
                  // Campos para editar el precio y las copias con etiquetas
                  Row(
                    children: [
                      Expanded(child: Text('Precio:')),
                      Expanded(
                        child: Text(card['price'].toString()),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Incremento/Decremento de la cantidad de copias
                  Row(
                    children: [
                      Expanded(child: Text('Cantidad:')),
                      Expanded(// Ancho del campo de texto para la cantidad
                        child: Text(card['copies'].toString())
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

  // void copiarAlPortapapeles(String texto) {
  //   Clipboard.setData(ClipboardData(text: folderId!));
  // }

  @override
  void initState() {
    super.initState();
    _fetchCardsFromFolder(widget.folderId);
  }

  @override
  Widget build(BuildContext context) {

    final items = <Widget>[
      Icon(Icons.home, color: Color(0xFFEBEEF2),),
      Icon(Icons.folder_shared,color: Color(0xFFEBEEF2),),
      //Icon(Icons.create_new_folder,color: Color(0xFFEBEEF2),),
      ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(folderName, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFFEBEEF2))),
        backgroundColor: const Color(0xFF104E75), // Color del encabezado
        iconTheme: const IconThemeData(color:  Color(0xFFEBEEF2)),
        
      ),
      bottomNavigationBar: CurvedNavigationBar(
          key: navigationKey,
          backgroundColor: const Color(0xFFEBEEF2),
          buttonBackgroundColor: const Color(0xFF6194B8),
          color: Color(0xFF104E75),
          animationDuration: const Duration(milliseconds: 300),
          height: 60,
          //type: BottomNavigationBarType.shifting,
          /* currentIndex: selectedIndex,
          onTap: (value) => setState(() => selectedIndex = value),
          elevation: 2,
          backgroundColor: const Color(0xFF104E75),
          selectedItemColor: Color(0xFFEBEEF2), */ // Color del ícono activo
          items: items,
          index: index,
          onTap: (value) {
            setState(() {
              index = value;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => screens[index],
                ),
              );
            });
          },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar carta...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (query) {
                setState(() {
                  searchQuery = query; // Actualizar la búsqueda
                });
              },
            ),
          ),
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
                itemCount: filteredCards.length,
                itemBuilder: (context, index) {
                  final card = filteredCards[index];
                  return GestureDetector(
                    onTap: () {
                      _showCardDetail(context, index); // Mostrar carta en grande al hacer clic
                    },
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Image.asset(
                                'images/zagreus.jpg', // Imagen de la carta
                                fit: BoxFit.cover,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$${card['price']}',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          bottom: 40,
                          right: 10,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: Text(
                              'x${card['copies']}',
                              style: TextStyle(color: Color(0xFF6194B8), fontSize: 14),
                            ),
                          ),
                        ),
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
