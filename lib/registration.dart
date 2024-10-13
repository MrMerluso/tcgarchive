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
        useMaterial3: true, // Activa Material Design 3.0
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF104E75)),
      ),
      home: const SignUpScreen(),
    );
  }
}


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false; // Estado para la visibilidad de la contraseña
  bool _repeatPasswordVisible = false; // Estado para la visibilidad de la repetición de contraseña

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CREATE YOUR ACCOUNT", style: TextStyle(color: Color(0xFFEBEEF2), fontWeight: FontWeight.bold)),
        centerTitle: true, // Centra el título
        backgroundColor: Theme.of(context).colorScheme.primary,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  'images/Logo.png',
                  height: 200,
                  ),
                const SizedBox(height: 50),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de contraseña con visibilidad alternable
                TextFormField(
                  obscureText: !_passwordVisible, // Cambia la visibilidad según el estado
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible; // Cambia el estado al tocar el ícono
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Campo para repetir contraseña con visibilidad alternable
                TextFormField(
                  obscureText: !_repeatPasswordVisible, // Cambia la visibilidad según el estado
                  decoration: InputDecoration(
                    labelText: 'Repeat Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _repeatPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _repeatPasswordVisible = !_repeatPasswordVisible; // Cambia el estado al tocar el ícono
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción para crear la cuenta
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(fontSize: 20, color: Color(0xFFEBEEF2), fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
