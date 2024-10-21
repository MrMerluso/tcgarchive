// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tcgarchive/carpeta_compartida.dart';
import 'package:tcgarchive/views/ventana_carpetas.dart';

class SelectTcgScreen extends StatefulWidget {
  @override
  _SelectTcgScreenState createState() => _SelectTcgScreenState();
}

class _SelectTcgScreenState extends State<SelectTcgScreen> {
  final List<String> tcgOptions = [
    'JCC Pokemon',
    'Mitos y Leyendas',
    'One Piece CG',
  ];
  final List<String> tcgImages = [
    'images/Logo-JCCPkmn.png',
    'images/Logo-MyL.png',
    'images/Logo-OPCG.png',
  ];
  final List<String> tcgName = [
    'cardsPkmntcg',
    'cardsMyl',
    'cardsOpcg',
  ];

  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  int index = 2;

  final screens = [
    SearchFolder(),
    HomeScreen(),
    SelectTcgScreen()
  ];

  Future<String?> _showFolderNameDialog(BuildContext context, String tcgName) {
    final TextEditingController folderNameController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingrese el nombre de la carpeta'),
          content: TextField(
            controller: folderNameController,
            decoration: InputDecoration(hintText: 'Nombre de la carpeta'),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // No retornar nada
              },
            ),
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                String name = folderNameController.text;
                Navigator.of(context).pop(name); // Retornar el nombre de la carpeta
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.copy,color: Color(0xFFEBEEF2),),
      Icon(Icons.home, color: Color(0xFFEBEEF2),),
      Icon(Icons.create_new_folder,color: Color(0xFFEBEEF2),),
      ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFEBEEF2)),
        centerTitle: true,
        title: Text('Seleccionar TCG', style: TextStyle(color: Color(0xFFEBEEF2), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF104E75),
        
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: tcgOptions.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                String? folderName = await _showFolderNameDialog(context, tcgOptions[index]);
                String nameIdx = tcgName[index];

                Map<String, dynamic> newFolderDetails = {"folderName": folderName, "nameIdx": nameIdx};
                
                if (newFolderDetails != null && newFolderDetails.isNotEmpty) {
                  Navigator.pop(context, newFolderDetails); // Retorna el nombre de la carpeta
                }
              },
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
                              tcgImages[index],
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFF6194B8),
                            ),
                            child: Text(
                              tcgOptions[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white, 
                                fontSize: 24
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              );
            },
          ),
        ),
      );
  }
}
