import 'package:flutter/material.dart';
import 'package:tcgarchive/views/ventana_cartas_compartida.dart';

// void main() {
//   runApp(const MyApp());
// }

class SearchFolder extends StatelessWidget {
  const SearchFolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comunidad', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFFEBEEF2))),
          centerTitle: true,
          backgroundColor: const Color(0xFF104E75),
          iconTheme: const IconThemeData(color:  Color(0xFFEBEEF2)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFEBEEF2)),
            onPressed: () {
              // Acción para retroceder
              Navigator.pop(context);
            },
          ),
          
        ),
        body: const SearchPage(),
      );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _codeController = TextEditingController(); // Controlador para el campo de texto

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
      )
    );
    
    // Aquí puedes agregar la lógica de búsqueda o validación del código
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
              controller: _codeController, // Asignar el controlador al TextField
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
