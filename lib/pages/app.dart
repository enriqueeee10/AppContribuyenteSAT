import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Opcional: oculta el banner de debug
      home: LoginApp(),
    );
  }
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(),
    );
  }
}

Widget cuerpo() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/fondoGradiente.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        logo(),
        const SizedBox(height: 20),
        campoUsuario(),
        const SizedBox(height: 20),
        campoContrasena(),
        const SizedBox(height: 20),
        botonIngresar(),
      ],
    ),
  );
}

Widget campoUsuario() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 40),
    child: TextField(
      decoration: const InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.white,
        ),
        hintText: "Correo Electrónico",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}

Widget campoContrasena() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 40),
    child: TextField(
      obscureText: true,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.person,
          color: Colors.white,
        ),
        hintText: "Código Contribuyente",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}

Widget botonIngresar() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 40),
    child: ElevatedButton(
      onPressed: () {},
      child: const Text("Ingresar"),
    ),
  );
}

/// Returns a white "Login" text with a font size of 40.
Widget logo() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/logopeque.png"),
      ),
    ),
  );
}
