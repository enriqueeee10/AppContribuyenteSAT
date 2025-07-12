import 'package:flutter/material.dart';
import 'package:flutter_application_rest/pages/login.dart';
import 'package:flutter_application_rest/pages/menu.dart';
import 'package:flutter_application_rest/pages/splashPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Muestra el SplashScreen al inicio
    );
  }
}
