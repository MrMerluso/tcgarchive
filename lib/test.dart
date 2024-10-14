import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('GridView Example')),
        body:Padding(
          padding: const EdgeInsets.all(6.0),
          child:
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
              splashColor: Color(/* 0xFF6194B8 */0xFFEBEEF2),
              child: GridTile(
                child: Stack(
                  children: [

                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only (top:20, right: 10, bottom: 10, left: 10),
                      margin: EdgeInsets.symmetric(vertical:15,horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFEBEEF2), // Fondo blanco
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Color de la sombra
                              spreadRadius: 2, // Propagación de la sombra
                              blurRadius: 5, // Difuminado de la sombra
                              offset: Offset(0, 3), // Desplazamiento de la sombra
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
                            style: TextStyle(
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
      ),
     ) 
    );
  }
}

