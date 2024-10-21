import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tcgarchive/controllers/user_controller.dart';
import 'package:tcgarchive/registration.dart';
import 'package:tcgarchive/views/ventana_carpetas.dart';

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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserController _userController = UserController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    bool loginexito = await _userController.loginWithUsername(username, password);

    if (!loginexito) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario o contraseña incorrectos'),
          backgroundColor: Colors.red,
        ),
      );
      
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );

    print('Username: $username');
    print('Password: $password');
  }

  

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _checkUserSession();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Permitir que el cuerpo se ajuste al teclado
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Username Field
                        TextField(
                          controller: _usernameController,
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
                          controller: _passwordController,
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Checkbox(
                        //           value: false,
                        //           onChanged: (newValue) {},
                        //         ),
                        //         const Text('Remember Me'),
                        //       ],
                        //     ),
                        //     TextButton(
                        //       onPressed: () {
                        //         // Acción para "Forgot Password?"
                        //       },
                        //       child: const Text('Forgot Password?'),
                        //     ),
                        //   ],
                        // ),
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
                              backgroundColor: const Color(0xFF104E75),
                            ),
                            onPressed: _onLogin,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
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
          ),
          // Logo colocado en el rectángulo blanco, sobre la tarjeta
          Positioned(
            top: MediaQuery.of(context).size.height * 0.2 - (MediaQuery.of(context).viewInsets.bottom > 0 ? 110 : 0), // Ajusta la posición vertical
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
