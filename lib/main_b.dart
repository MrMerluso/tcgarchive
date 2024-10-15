import 'package:flutter/material.dart';
import 'views/ventana_carpetas.dart';
import 'views/ventana_tcg.dart';
import 'views/ventana_cartas.dart'; // Asegúrate de importar la pantalla de cartas

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF104E75),
        ),
        scaffoldBackgroundColor: const Color(0xFFEBEEF2),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color(0xFFEBEEF2)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/select-tcg': (context) => SelectTcgScreen(),
        '/cards': (context) => CardScreen(folderName: 'defaultFolder', cards: [], tcg: 'cardsPkmntcg'), // Nueva ruta para la ventana de cartas
      },
    );
  }
}
