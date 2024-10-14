// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SelectTcgScreen extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Seleccionar TCG', style: TextStyle(color: Color(0xFFEBEEF2), fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF104E75),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 50,
          ),
          itemCount: tcgOptions.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                String? folderName = await _showFolderNameDialog(context, tcgOptions[index]);
                if (folderName != null && folderName.isNotEmpty) {
                  Navigator.pop(context, folderName); // Retorna el nombre de la carpeta
                }
              },
              child: Card(
                color: Color(0xFFEBEEF2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          tcgImages[index],
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    Container(
                      color: Color(0xFF6194B8),
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tcgOptions[index],
                        style: TextStyle(color: Colors.white, fontSize: 26),
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
    );
  }
}
