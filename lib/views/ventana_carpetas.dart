// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'ventana_tcg.dart'; // Asegúrate de importar SelectTcgScreen
import 'ventana_cartas.dart'; // Asegúrate de importar CardScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Cambiar a un mapa para almacenar información adicional de cada carpeta
  List<Map<String, dynamic>> folders = []; // Almacena el nombre de la carpeta y sus cartas

  void _createNewFolder() async {
    final String? newFolderName = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectTcgScreen()),
    );
    
    if (newFolderName != null && newFolderName.isNotEmpty) {
      setState(() {
        // Inicializa correctamente la lista de cartas como una lista vacía
        folders.add({'name': newFolderName, 'cards': <Map<String, dynamic>>[]}); 
      });
    }
  }

  void _viewCards(int index) {
    // Navegar a la ventana de cartas y pasar el nombre de la carpeta
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardScreen(
          folderName: folders[index]['name'], 
          cards: folders[index]['cards'], // Asegúrate de que esto sea del tipo correcto
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tus Carpetas', style: TextStyle(color: Color(0xFFEBEEF2), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF104E75),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Color(0xFFEBEEF2),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xFF104E75),
                ),
                child: Text(
                  'Opciones',
                  style: TextStyle(
                    color: Color(0xFFEBEEF2),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.copy),
              title: Text('Copiar código carpeta compartida'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.create_new_folder),
              title: Text('Crear nueva carpeta'),
              onTap: _createNewFolder, // Llamar a la función de crear carpeta
            ),
          ],
        ),
      ),
      body: Column(children: [
        Padding(padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar carpeta...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: folders.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _viewCards(index), // Navegar a la ventana de cartas
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.grey[300], // Cambia esto por la imagen más adelante
                            child: Center(
                              child: Text(
                                'Imagen', // Reemplaza con una imagen real más adelante
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF6194B8),
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            folders[index]['name'], // Mostrar el nombre de la carpeta
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
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
      ]),
    );
  }
}
