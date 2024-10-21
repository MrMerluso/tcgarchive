import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcgarchive/login.dart';
import 'package:tcgarchive/views/ventana_carpetas.dart';

class LoginSplashscreen extends StatefulWidget {
  const LoginSplashscreen({super.key});

  @override
  State<LoginSplashscreen> createState() => _LoginSplashscreenState();
}

class _LoginSplashscreenState extends State<LoginSplashscreen> {
  
  Future<void> _checkUserSession() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Si hay un usuario autenticado, redirigir a la pantalla principal
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        )
      );
    } else {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => TCGApp(),
        )
      );
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), () {
      _checkUserSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/Logo.png",
                width: 200,
              ),
            ],
          ),
        )
      )
    );
  }
}