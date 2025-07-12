import 'package:flutter/material.dart';
import 'package:flutter_application_rest/pages/deudas.dart';
import 'package:flutter_application_rest/pages/multasPage.dart';
import 'package:flutter_application_rest/pages/pagosPage.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa url_launcher

class menuScreen extends StatelessWidget {
  const menuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo2.png",
                    height: 100, // Ajusta la altura según sea necesario
                    width: 200, // Ajusta el ancho según sea necesario
                    fit: BoxFit.fill),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                color: Colors.blue.shade900,
                child: Row(),
              ),
            ],
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(50),
              crossAxisCount: 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              children: [
                _buildIconButton(
                    context,
                    Icons.search,
                    "Consulta Deuda Tributaria",
                    DeudasScreen(),
                    false), // No es una función
                _buildIconButton(
                    context,
                    Icons.motorcycle_outlined,
                    "Consulta Multa de Tránsito",
                    MultasBusquedaScreen(),
                    false), // No es una función
                _buildIconButton(
                  context,
                  Icons.payment_outlined,
                  "Pagos en línea",
                  PagosScreen(),
                  false, // No es una función
                ),
                _buildIconButton(
                  context,
                  Icons.phone,
                  "Contáctanos",
                  () => ContactoOpcion(
                    icon: Icons.phone,
                    texto: "Contáctenos",
                    url: "tel:938553393",
                  ),
                  true, // Es una función
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, IconData icon, String label,
      dynamic destination, bool isFunction) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade900,
        padding: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
      ),
      onPressed: () {
        if (isFunction) {
          (destination as Function)(); // Llama a la función
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    destination as Widget), // Navega a la página
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.blue.shade900),
          SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void ContactoOpcion(
      {required IconData icon,
      required String texto,
      required String url}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'No se pudo abrir $url';
    }
  }
}
