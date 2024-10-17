import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  
  @override
  _MyAppState createState() => _MyAppState();

}


class _MyAppState extends State<MyApp> {
  
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( // Tema de la aplicación
        useMaterial3: true, // Color principal
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF104E75)),
        scaffoldBackgroundColor: const Color(0xFFEBEEF2), // Color de la semilla
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Color(0xFFEBEEF2)), // Color de los iconos
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GridView Example'),
          backgroundColor: const Color(0xFF104E75),
          ),
        bottomNavigationBar: CurvedNavigationBar(
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
          items: const [
           Icon(Icons.home, color: Color(0xFFEBEEF2),),
           Icon(Icons.search,color: Color(0xFFEBEEF2),),
           Icon(Icons.notifications,color: Color(0xFFEBEEF2),),
           Icon(Icons.account_circle,color: Color(0xFFEBEEF2),),
          ],
        ),
        body: const Test(), // Llamada al widget Test
     ) 
    );
  }
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {

    return Padding(
          padding: const EdgeInsets.all(6.0),
          child:
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 elementos por fila
            childAspectRatio: 0.8, // Proporción de ancho a alto
          ),
          itemCount: 10, // Número de elementos
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                // Aquí defines lo que sucede al hacer clic en el elemento
                print('Elemento $index clickeado');
              },
              borderRadius: BorderRadius.circular(20),
              splashColor: const Color(/* 0xFF6194B8 */0xFFEBEEF2),
              child: GridTile(
                child: Stack(
                  children: [

                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only (top:20, right: 10, bottom: 10, left: 10),
                      margin: const EdgeInsets.symmetric(vertical:15,horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBEEF2), // Fondo blanco
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Color de la sombra
                              spreadRadius: 2, // Propagación de la sombra
                              blurRadius: 5, // Difuminado de la sombra
                              offset: const Offset(0, 3), // Desplazamiento de la sombra
                            ),
                          ],
                      ),
                      //margin: const EdgeInsets.symmetric(vertical:8,horizontal: 15), // Margen alrededor de cada elemento
                    child : Column(
                      children: [
                        
                        // Imagen
                        Expanded(
                          child: Image.asset(
                            'images/Carpeta-azul/Carpeta-azul-myl.png', // Asegúrate de que tus imágenes estén en esta ruta
                            fit: BoxFit.none, //
                            scale: 2,
                          ),
                        ),
                        // Espacio pequeño entre la imagen y el texto
                        // Texto dentro de un container con fondo rojo y bordes redondeados
                        Container(
                          // Espacio pequeño entre la imagen y el texto
                          width: 170,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Padding dentro del container
                          decoration: BoxDecoration(
                            color: Colors.red, // Fondo rojo
                            borderRadius: BorderRadius.circular(12), // Bordes redondeados
                          ),
                          child: Text(
                            'Texto ${index + 1}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFEBEEF2), // Color del texto
                            ),
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
      );}
}