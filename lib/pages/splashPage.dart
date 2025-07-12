import 'package:flutter/material.dart';
import 'package:flutter_application_rest/pages/menu.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simula una carga de 3 segundos
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => menuScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/logo2.png", height: 150, width: 250),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade900),
            ),

            // Padding(padding: const EdgeInsets.only(bottom: 10.0)),
            // Text(
            //   "v1.0.0", // Versión de la aplicación
            //   style: TextStyle(
            //     fontFamily: 'Roboto', // Fuente personalizada
            //     fontSize: 20,
            //     color: Colors.black, // Color del texto
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
