// ignore_for_file: prefer_const_constructors, must_be_immutable


import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcgarchive/carpeta_compartida.dart';

import 'package:tcgarchive/controllers/folders_controller.dart';
import 'package:tcgarchive/login.dart';
import 'package:tcgarchive/models/folders_model.dart';
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
  FoldersController _foldersController = FoldersController();
  bool _isLoading = true;
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  int index = 1;

  final screens = [
    SearchFolder(),
    HomeScreen(),
    SelectTcgScreen()
  ];



  List<Map<String, dynamic>> get folders {
    if (searchQuery.isEmpty) {
      return widget.folders; // Mostrar todas las carpetas si no hay búsqueda
    }

    return widget.folders.where((folder) {
      return folder['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  set folders (List<Map<String, dynamic>> value){
    setState(() {
      widget.folders = value;
    });
  }

  void _createNewFolder() async {
    // final String? newFolderName = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => SelectTcgScreen()),
    // );

    final Map<String, dynamic>? newFolderDetails = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectTcgScreen()),
    );

    if (newFolderDetails== null || newFolderDetails["folderName"] == null) {
      return;
    } else {
      FoldersModel newFolder = await _foldersController.createFolder(newFolderDetails["folderName"], newFolderDetails["nameIdx"]);
      if (newFolder != null) {
        setState(() {
          // Inicializa correctamente la lista de cartas como una lista vacía
          folders.add({
            'id': newFolder.id,
            'name': newFolder.folderName,
            'createdBy': newFolder.createdBy,
            'tcg': newFolder.tcg,
            'cards': <Map<String, dynamic>>[],
          }); 
        });
      }
    }
  }
  Future<void> _fectchFolders() async{

    setState(() {
      _isLoading = true; // Inicia la carga
    });

    //print("WENAWENAWENAWENAWENAWENAWENAWENAWENAWENAWENAWENAWENAWENAWENAWENA");

    List<FoldersModel> fetchedFolders = await _foldersController.getFoldersFromUser();
    
    // print(fetchedFolders);
    List<Map<String, dynamic>> foldersss = [];

    for (var i = 0; i < fetchedFolders.length; i++) {
      var f = fetchedFolders[i];

      List<Map<String, dynamic>> fetchedCards = await _foldersController.getCardsFromFolder(f.id!);

      foldersss.add({
        'id': f.id,
        'name': f.folderName,
        'createdBy': f.createdBy,
        'tcg': f.tcg,
        'cards': fetchedCards, 
      });
      
    }

    
    setState(() {
      folders = foldersss;
      //print("Antes$_isLoading");
      _isLoading = false; // Finaliza la carga
      //print("Despues$_isLoading");
    });

    //print(folders);
  }

  void _viewCards(int index) {
    if (folders[index]['name'] != null) {  // Verifica que 'name' no sea null
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CardScreen(
            folderName: folders[index]['name'] ?? 'Sin Nombre',  // Valor por defecto si es null
            cards: folders[index]['cards'], // Asegúrate de que 'cards' también exista y sea válido
            tcg: folders[index]['tcg'],
            folderId: folders[index]['id'],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fectchFolders();
  }


  @override
  Widget build(BuildContext context) {

    //_fectchFolders();
    final items = <Widget>[
      Icon(Icons.copy,color: Color(0xFFEBEEF2),),
      Icon(Icons.home, color: Color(0xFFEBEEF2),),
      Icon(Icons.create_new_folder,color: Color(0xFFEBEEF2),),
      ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tus Carpetas', style: TextStyle(color: Color(0xFFEBEEF2), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF104E75),
        iconTheme: const IconThemeData(color:  Color(0xFFEBEEF2)),
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
            print("index: $index");
            setState(() {
              index = value;
              print("index dps: $index");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => screens[index],
                ),
              );
            });
          },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 150,
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
              title: Text('Buscar carpeta compartida'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchFolder(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.create_new_folder),
              title: Text('Crear nueva carpeta'),
              onTap: _createNewFolder, // Llamar a la función de crear carpeta
            ),
            Spacer(), // Empuja la opción final hacia abajo
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar sesión'),
              onTap: () async {
                await FirebaseAuth.instance.signOut(); // Cierra sesión
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                ); 
              },
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
              setState(() {
                searchQuery = query;
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
                Text('Cargando carpetas...'),
              ],
            ),
          )
        ) 
        :
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: folders.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _viewCards(index);
                  },
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Color(0xFFEBEEF2),
                  child: GridTile(
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 20, right: 10, bottom: 10, left: 10),
                          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFEBEEF2),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  '${'images/Carpeta-azul/Carpeta-azul-'+folders[index]["tcg"]}.png',
                                  fit: BoxFit.none,
                                  scale: 2,
                                ),
                              ),
                              Container(
                                width: 170,
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Color(0xFF6194B8),
                                ),
                                child: Text(
                                  folders[index]['name'],
                                    style: TextStyle(
                                      color: Colors.white, 
                                      fontSize: 18
                                    ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
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
