import 'package:flutter/material.dart';

void main() {
  runApp(const TCGApp());
}

class TCGApp extends StatelessWidget {
  const TCGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCG Archive',
      theme: ThemeData(
        useMaterial3: true, // Activamos Material Design 3
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF104E75)), // Paleta de colores basada en un "seed color"
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Rectángulo azul ocupando 1/4 de la pantalla (debajo)
          Positioned(
            bottom: 0, // Coloca el azul en la parte inferior
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF104E75), // Color azul
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.0), // Bordes redondeados en la parte superior
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1.9, // 1/4 de la pantalla
            ),
          ),
          // Rectángulo blanco ocupando 3/4 de la pantalla (encima)
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFEBEEF2), // Color blanco
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.0), // Bordes redondeados en la parte inferior
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.75, // 3/4 de la pantalla
          ),
          // Card que contiene los campos de acceso
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Center(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  width: 400,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Username Field
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Password Field
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      // Remember Me and Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (newValue) {},
                              ),
                              const Text('Remember Me'),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // Acción para "Forgot Password?"
                            },
                            child: const Text('Forgot Password?'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            backgroundColor: Color(0xFF104E75),
                          ),
                          onPressed: () {
                            // Acción de inicio de sesión
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Create Account Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                            onPressed: () {
                              // Acción para crear una cuenta
                            },
                            child: const Text('Create an account'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Logo colocado en el rectángulo blanco, sobre la tarjeta
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2, // Ajusta la posición vertical
            left: MediaQuery.of(context).size.width * 0.5 - 125, // Centrar horizontalmente
            child: Image.asset(
              'images/Logo.png', // Coloca aquí la imagen del logo
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}