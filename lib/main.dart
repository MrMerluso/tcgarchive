import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tcgarchive/views/addCards/add_cards.dart';
import 'package:tcgarchive/views/folders/ventana_carpetas.dart';
import 'package:tcgarchive/views/folders/ventana_cartas.dart';
import 'package:tcgarchive/views/folders/ventana_tcg.dart';
import 'package:tcgarchive/views/login/login.dart';
import 'package:tcgarchive/views/login/login_splashscreen.dart';
import 'package:tcgarchive/views/login/registration.dart';
import 'package:tcgarchive/views/share/carpeta_compartida.dart';
import 'firebase_options.dart'; // Importa esto si no está incluido

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        // Agrega más Providers aquí si es necesario
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
          '/': (context) => const LoginSplashscreen(),
          '/login': (context) => TCGApp(),
          '/home': (context) => HomeScreen(),
          '/register': (context) => SignUpScreen(),
          '/select-tcg': (context) => SelectTcgScreen(),
          '/cards': (context) => CardScreen(
                folderName: 'defaultFolder',
                cards: [],
                tcg: 'cardsPkmntcg',
              ), // Nueva ruta para la ventana de cartas
          '/shared-folder': (context) => SearchFolder(),
          '/add-cards': (context) => AddCards(
                folderName: '',
                cards: [],
                tcg: 'cardsPkmntcg',
                folderId: '',
              ),
        },
      ),
    );
  }
}
