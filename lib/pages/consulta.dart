import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Página WebView
class DeudasWebView extends StatefulWidget {
  const DeudasWebView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeudasWebViewState createState() => _DeudasWebViewState();
}

class _DeudasWebViewState extends State<DeudasWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Habilita JS
      ..loadRequest(
          Uri.parse('https://sat-t.gob.pe/consulta_deuda_tributaria'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Deudas')),
      body: WebViewWidget(controller: controller),
    );
  }
}

// Página principal con el botón de pago
class PagoDeuda extends StatelessWidget {
  final double montoTotal = 150.75;

  const PagoDeuda({super.key}); // Ejemplo de monto

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pago de Deuda")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total a pagar: S/. ${montoTotal.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: montoTotal > 0
                ? () {
                    // Navega a la página con el WebView
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DeudasWebView()),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 54, 226, 45),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Text("Pagar"),
          ),
        ],
      ),
    );
  }
}
