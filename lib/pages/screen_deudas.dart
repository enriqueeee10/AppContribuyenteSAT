import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/contribuyente_card.dart';
import '../widgets/cuota_table.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Importa el WebView

class DeudasPage extends StatefulWidget {
  final String email;
  final String codigo;

  const DeudasPage({super.key, required this.email, required this.codigo});

  @override
  // ignore: library_private_types_in_public_api
  _DeudasPageState createState() => _DeudasPageState();
}

class _DeudasPageState extends State<DeudasPage> {
  Map<String, dynamic>? contribuyente;
  List<Map<String, dynamic>> cuotas = [];
  Map<int, bool> seleccionadas = {};
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchContribuyente();
  }

  Future<void> fetchContribuyente() async {
    final url = Uri.parse(
        'http://190.119.38.13/getValidaEmailContribuyente/${widget.email}/${widget.codigo}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success' && data['data'].isNotEmpty) {
          setState(() {
            contribuyente = data['data'][0];
            cuotas =
                List<Map<String, dynamic>>.from(data['data'][0]['deudas_json']);
            seleccionadas = {for (int i = 0; i < cuotas.length; i++) i: false};
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Datos incorrectos';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Error en la consulta';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'No se pudo conectar con el servidor';
        isLoading = false;
      });
    }
  }

  // Mostrar el diálogo de advertencia
  void mostrarAdvertencia() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Aviso de Redirección"),
          content: Text(
              "Estimado contribuyente, usted está siendo redireccionado a una página segura, por favor vuelva a ingresar su código de contribuyente."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                irAlPago(); // Navega al WebView
              },
              child: Text("Continuar"),
            ),
          ],
        );
      },
    );
  }

  // Navegar al WebView
  void irAlPago() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeudasWebView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deudas del Contribuyente')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(errorMessage, style: TextStyle(color: Colors.red)))
              : contribuyente == null
                  ? Center(child: Text('No hay datos disponibles'))
                  : Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ContribuyenteCard(contribuyente: contribuyente!),
                          SizedBox(height: 5),
                          Expanded(
                            child: CuotaTable(
                              cuotas: cuotas,
                              seleccionadas: seleccionadas,
                              onSelectionChanged: (index, value) {
                                setState(() {
                                  seleccionadas[index] = value;
                                });
                              },
                              onSelectAll: (value) {
                                setState(() {
                                  seleccionadas.updateAll((key, _) => value);
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: mostrarAdvertencia, // Siempre habilitado
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 54, 226, 45),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Text("Pagar"),
                          ),
                          SizedBox(height: 80),
                        ],
                      ),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: const Color.fromARGB(255, 4, 167, 39),
        child: Icon(
          Icons.logout,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}

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
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
          Uri.parse('https://sat-t.gob.pe/consulta_deuda_tributaria'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consulta de Deuda')),
      body: WebViewWidget(controller: controller),
    );
  }
}
