// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardScreen extends StatefulWidget {
  final String folderName; // Nombre de la carpeta
  final List<Map<String, dynamic>> cards; // Lista de cartas para esta carpeta

  const CardScreen({super.key, required this.folderName, required this.cards});

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  String searchQuery = ''; // Búsqueda de cartas

  List<Map<String, dynamic>> get filteredCards {
    if (searchQuery.isEmpty) {
      return widget.cards; // Mostrar todas las cartas si no hay búsqueda
    }

    return widget.cards.where((card) {
      return card['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  void _addCard() async {
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
                decoration: InputDecoration(hintText: 'Buscar carta'),
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
                if (name.isNotEmpty && copies > 0) {
                  Navigator.of(context).pop({'name': name, 'copies': copies}); // Pasar datos de la carta
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

  // Función para mostrar la imagen en grande
  void _showCardDetail(BuildContext context, String cardName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Aquí mostrarías la imagen grande de la carta
                Container(
                  height: 600, // Tamaño de la imagen ampliada
                  color: Colors.grey[300], // Placeholder de la imagen
                  child: Center(
                    child: Text(
                      cardName, // Mostrar el nombre de la carta
                      style: TextStyle(fontSize: 24), // Tamaño de texto más grande
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  child: Text('Cerrar'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Cerrar el diálogo
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderName, style: const TextStyle(color: Color(0xFFEBEEF2), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF104E75), // Color del encabezado
      ),
      body: Column(children: [
          Padding(padding: const EdgeInsets.all(16.0),
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
                  crossAxisCount: 4,
                  childAspectRatio: 0.6, // Proporción más rectangular
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
                ),
                itemCount: filteredCards.length,
                itemBuilder: (context, index) {
                  final card = filteredCards[index];
                  return GestureDetector(
                    onTap: () {
                      _showCardDetail(context, card['name']); // Mostrar carta en grande al hacer clic
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20), // Bordes redondeados
                        border: Border.all(color: Colors.grey, width: 2), // Borde gris alrededor de la carta
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[500], // Color gris como placeholder
                              borderRadius: BorderRadius.circular(20), // Mantiene los bordes redondeados
                            ),
                            child: Center(
                              child: Text(
                                card['name'], // Mostrar el nombre de la carta
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 16, // Tamaño del círculo
                              backgroundColor: Colors.white,
                              child: Text(
                                'x${card['copies']}', // Mostrar la cantidad de copias
                                style: TextStyle(color: Color(0xFF6194B8), fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),    
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        backgroundColor: Color(0xFF104E75), // Color del botón
        child: Icon(Icons.add, color: Color(0xFFEBEEF2)),
      ),
    );
  }
}
