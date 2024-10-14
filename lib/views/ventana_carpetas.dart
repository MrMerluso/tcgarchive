// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'ventana_tcg.dart'; // Asegúrate de importar SelectTcgScreen
import 'ventana_cartas.dart'; // Asegúrate de importar CardScreen

class HomeScreen extends StatefulWidget {
  List<Map<String, dynamic>> folders = [];

  HomeScreen({super.key}); // Almacena el nombre de la carpeta y sus cartas
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Cambiar a un mapa para almacenar información adicional de cada carpeta
  String searchQuery = ''; // Búsqueda de carpetas

  List<Map<String, dynamic>> get folders {
    if (searchQuery.isEmpty) {
      return widget.folders; // Mostrar todas las carpetas si no hay búsqueda
    }

    return widget.folders.where((folder) {
      return folder['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

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
  if (folders[index]['name'] != null) {  // Verifica que 'name' no sea null
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardScreen(
          folderName: folders[index]['name'] ?? 'Sin Nombre',  // Valor por defecto si es null
          cards: folders[index]['cards'], // Asegúrate de que 'cards' también exista y sea válido
        ),
      ),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            onChanged: (query) {
                searchQuery = query;
            },
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
                    color: Color(0xFFEBEEF2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              'images/Logo-MyL.png',
                              fit: BoxFit.cover,
                              //scale: 1.5,
                            ),
                          ),
                        ),
                        Container(
                          
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFF6194B8),),
                          
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
