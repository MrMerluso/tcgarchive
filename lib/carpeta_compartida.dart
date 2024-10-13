import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF104E75)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Comunidad', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xFFEBEEF2))),
          centerTitle: true,
          backgroundColor: const Color(0xFF104E75),
          leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFEBEEF2),),
          onPressed: () {
            // Acción para retroceder
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFEBEEF2),),
            onPressed: () {
              // Acción para el menú
            },
          ),
        ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
    
              children: [
                const SizedBox(height: 150,),
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
                  decoration: InputDecoration(
                    labelText: 'Código',
                    suffixIcon: IconButton(
                      onPressed: (){}, icon: const Icon(Icons.search)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0)
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF104E75),
                    
                  ),
                  onPressed: () {
                    // Acción al presionar el botón
                  },
                  child: const Text('Buscar', style: TextStyle(color: Color(0xFFEBEEF2))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
