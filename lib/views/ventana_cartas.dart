// ignore_for_file: prefer_const_constructors
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

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
                          setState(() {
                            widget.cards.removeAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Carta eliminada', style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.red,
                            ),
                            ); // Eliminar la carta
                          });
                          Navigator.of(context).pop(); // Cerrar el diálogo
                        },
                      ),
                      TextButton(
                        child: Text('Guardar'),
                        onPressed: () {
                          setState(() {
                            card['price'] = double.tryParse(cardPriceController.text) ?? 0.0;
                            card['copies'] = int.tryParse(cardCopiesController.text) ?? 0;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cambios guardados', style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.green,
                            ),
                            );
                          });
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
  Clipboard.setData(ClipboardData(text: texto));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.share),
              onPressed: () {
                copiarAlPortapapeles("id de la base de datos");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                  backgroundColor: Colors.green,
                  content: Row(
                    children: const [
                      Icon(
                        Icons.copy_sharp, // Elige el icono que prefieras
                        color: Colors.white,
                      ),
                    SizedBox(width: 10), // Espacio entre el icono y el texto
                      Text('Código copiado en portapapeles', style: TextStyle(color: Colors.white)),
                    ],
                  ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        backgroundColor: const Color(0xFF104E75), // Color del botón
        child: Icon(Icons.add, color: Color(0xFFEBEEF2)),
      ),
    );
  }
}
