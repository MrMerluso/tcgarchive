// ignore_for_file: prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tcgarchive/controllers/folders_controller.dart';
import 'package:tcgarchive/models/cardsmyl_model.dart';
import 'package:tcgarchive/models/cardsopcg_model.dart';
import 'package:tcgarchive/models/cardspkmntcg_model.dart';
import 'package:tcgarchive/views/addCards/add_cards.dart';

class CardScreen extends StatefulWidget {
  final String folderName; // Nombre de la carpeta
  List<Map<String, dynamic>> cards; // Lista de cartas para esta carpeta
  final String tcg;
  final String? folderId;
  final FoldersController _foldersController = FoldersController();

  CardScreen({super.key, required this.folderName, required this.cards, required this.tcg, this.folderId});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
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

   setState(() {
     _isLoading = true;
   });

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

    cards = newCards;

    setState(() {
      _isLoading = false;
    });

  }

  void _addCard() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCards(folderName: widget.folderName, cards: [], tcg: widget.tcg, folderId: widget.folderId),
      ),
    );
    /* final Map<String, dynamic>? newCard = await showDialog<Map<String, dynamic>>(
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
    } */
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
                    height: 450, // Tamaño de la imagen ampliada
                    color: Colors.grey[300], // Placeholder de la imagen
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

  void copiarAlPortapapeles(String texto) {
    Clipboard.setData(ClipboardData(text: widget.folderId!));
  }

  @override
  void initState() {
    super.initState();
    // _fetchCards();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchCards();
  }

  void _addCardToFolder() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCards(folderName: widget.folderName, cards: [], tcg: widget.tcg, folderId: widget.folderId),
      ),
    );
    setState(() {
      _fetchCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color:  Color(0xFFEBEEF2)),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
              onPressed: () {
                copiarAlPortapapeles("id de la base de datos");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 1500),
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.only(
                      bottom: 10.0, // Ajusta este valor para la distancia deseada del FAB
                      left: 16.0,
                      right: 16.0,
                      ),
                  backgroundColor: Colors.green,
                  content:  Text('Código copiado en portapapeles', style: TextStyle(color: Colors.white)),
                ),
              );
            },
          ),
        ],
        centerTitle: true,
        title: Text(widget.folderName, style: const TextStyle(color: Color(0xFFEBEEF2), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF104E75), // Color del encabezado
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF104E75),
        child: Icon(Icons.add, color: Color(0xFFEBEEF2)),
        onPressed: _addCardToFolder
        
        //_addCard, // Navegar a la pantalla de añadir carta
        //backgroundColor: const Color(0xFF104E75), // Color del botón
        //child: Icon(Icons.add, color: Color(0xFFEBEEF2)),
        //tooltip: "Añadir carta",
      ),
    );
  }
}
