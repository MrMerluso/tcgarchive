// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:tcgarchive/controllers/folders_controller.dart';
import 'package:tcgarchive/models/cardsmyl_model.dart';
import 'package:tcgarchive/models/cardsopcg_model.dart';
import 'package:tcgarchive/models/cardspkmntcg_model.dart';
import 'package:tcgarchive/models/folders_model.dart';
import 'package:tcgarchive/views/folders/ventana_carpetas.dart';
import 'package:tcgarchive/views/folders/ventana_tcg.dart';

import 'carpeta_compartida.dart';

class SharedFolder extends StatefulWidget {
  // final String folderName; // Nombre de la carpeta
  
  // final String tcg;
  final String folderId;
  final FoldersController _foldersController = FoldersController();

  SharedFolder({super.key, required this.folderId});

  @override
  _SharedFolderState createState() => _SharedFolderState();
}

class _SharedFolderState extends State<SharedFolder> {
  String searchQuery = ''; // Búsqueda de cartas
  String folderName = '';
  bool _isLoading = true;
  List<Map<String, dynamic>> cards = []; // Lista de cartas para esta carpeta


  //final FoldersController _foldersController = FoldersController();

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


  /*Future<void> _fetchCardsFromFolder(String folderId) async{
    
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


  }*/
   Future<void> _fetchCards() async{
    FoldersModel folder = await widget._foldersController.getFolderById(widget.folderId!);
   setState(() {
     _isLoading = true;
   });

    List<Map<String, dynamic>> cardsFromFolder = await widget._foldersController.getCardsFromFolder(widget.folderId!);

    List<Map<String, dynamic>> newCards = [];

    for (var card in cardsFromFolder) {
      switch (folder.tcg) {
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

    cards = newCards;

    setState(() {
      _isLoading = false;
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                    height: 450, // Tamaño de la imagen ampliada
                    color: Colors.grey[300], // Placeholder de la imagen
                    child: 
                      CachedNetworkImage(
                        imageUrl: card['Imagen'],
                        placeholder: (context, url) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("Cargando..."),
                          ],
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                  ),
                  SizedBox(height: 20),
                  // Campos para editar el precio y las copias con etiquetas
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Text('Precio:', style: TextStyle(fontSize: 20))
                      ),
                      Expanded(
                        child: Text(card['price'].toString(), style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Incremento/Decremento de la cantidad de copias
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Text('Cantidad:', style: TextStyle(fontSize: 20))
                      ),
                      Expanded(// Ancho del campo de texto para la cantidad
                        child: Text(card['copies'].toString(), 
                          style: TextStyle(
                            fontSize: 20,
                          )
                        ),
                      ),
                    ],  
                  ),
                ],  
              ),
            ),
          ),
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
    _fetchCards();
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
                              child: CachedNetworkImage(
                                imageUrl: card['Imagen'],
                                placeholder: (context, url) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 10),
                                    Text("Cargando..."),
                                  ],
                                ),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          //card['price'] != 0
                            //? 
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '\$${card['price']}',
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                  ),
                                )
                            //: SizedBox.shrink(),
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
