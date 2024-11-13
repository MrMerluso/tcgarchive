import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcgarchive/login.dart';
import 'package:tcgarchive/views/ventana_carpetas.dart';
import 'package:tcgarchive/views/ventana_cartas_compartida.dart';
import 'package:tcgarchive/views/ventana_tcg.dart';

class SearchFolder extends StatefulWidget {
  const SearchFolder({super.key});

  @override
  _SearchFolderState createState() => _SearchFolderState();
}

class _SearchFolderState extends State<SearchFolder> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 1;

  final screens = [
    HomeScreen(),
    const SearchFolder(), // Aquí puedes cambiar por una pantalla adecuada
    //SelectTcgScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, color: Color(0xFFEBEEF2)),
      const Icon(Icons.folder_shared, color: Color(0xFFEBEEF2)),
      //const Icon(Icons.create_new_folder, color: Color(0xFFEBEEF2)),
    ];

    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Comunidad',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color(0xFFEBEEF2))),
        centerTitle: true,
        backgroundColor: const Color(0xFF104E75),
        iconTheme: const IconThemeData(color: Color(0xFFEBEEF2)),
        leading: Container(),
        actions: [Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.person),
              color: Color(0xFFEBEEF2),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
                
              },
            );
          },
        )],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        backgroundColor: const Color(0xFFEBEEF2),
        buttonBackgroundColor: const Color(0xFF6194B8),
        color: const Color(0xFF104E75),
        animationDuration: const Duration(milliseconds: 300),
        height: 60,
        items: items,
        index: index,
        onTap: (value) {
          
          print("index: $value");
          

          setState(() {
            index = value;
            print("index dps: $index");
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screens[index],
            ),
          );
        },
      ),
      body: const SearchPage(),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xFF104E75),
                ),
                child: Icon(
                  Icons.account_circle,
                  size: 64,
                  color: Color(0xFFEBEEF2),
                )
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Editar perfil'),
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
              leading: Icon(Icons.password),
              title: Text('Cambiar contraseña'),
               // Llamar a la función de crear carpeta
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
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose(); // Liberar el controlador cuando no sea necesario
    super.dispose();
  }

  void _onSearch() {
    String code = _codeController.text; // Obtener el valor del input

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SharedFolder(folderId: code),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 150),
            const Text(
              'Inserte código de la carpeta pública',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF104E75),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Código',
                suffixIcon: IconButton(
                  onPressed: _onSearch,
                  icon: const Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF104E75),
              ),
              onPressed: _onSearch, // Acción al presionar el botón
              child: const Text('Buscar', style: TextStyle(color: Color(0xFFEBEEF2))),
            ),
          ],
        ),
      ),
    );
  }
}
