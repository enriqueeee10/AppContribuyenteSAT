import 'package:flutter/material.dart';
import 'package:flutter_application_rest/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consulta de Deuda',
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginScreen(), // Pantalla de inicio
    );
  }
}
