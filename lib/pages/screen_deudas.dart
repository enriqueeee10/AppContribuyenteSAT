import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/contribuyente_card.dart';
import '../widgets/cuota_table.dart';
import '../widgets/total_pagar.dart';

class DeudasPage extends StatefulWidget {
  final String email;
  final String codigo;

  const DeudasPage({super.key, required this.email, required this.codigo});

  @override
  _DeudasPageState createState() => _DeudasPageState();
}

class _DeudasPageState extends State<DeudasPage> {
  Map<String, dynamic>? contribuyente;
  List<Map<String, dynamic>> cuotas = [];
  Map<int, bool> seleccionadas = {};
  double montoTotal = 0.0;
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

  void actualizarMontoTotal() {
    double nuevoMontoTotal = 0.0;
    seleccionadas.forEach((index, isSelected) {
      if (isSelected) {
        nuevoMontoTotal += cuotas[index]['insoluto'] +
            cuotas[index]['reajuste'] +
            cuotas[index]['interes'] +
            cuotas[index]['gasto'];
      }
    });
    setState(() {
      montoTotal = nuevoMontoTotal;
    });
  }

  void seleccionarTodos(bool value) {
    setState(() {
      seleccionadas.updateAll((key, _) => value);
      actualizarMontoTotal();
    });
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
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ContribuyenteCard(contribuyente: contribuyente!),
                          SizedBox(height: 16),
                          Expanded(
                            child: CuotaTable(
                              cuotas: cuotas,
                              seleccionadas: seleccionadas,
                              onSelectionChanged: (index, value) {
                                setState(() {
                                  seleccionadas[index] = value;
                                  actualizarMontoTotal();
                                });
                              },
                              onSelectAll: seleccionarTodos,
                            ),
                          ),
                          TotalPagar(montoTotal: montoTotal),
                        ],
                      ),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: const Color.fromARGB(255, 49, 68, 239),
        child: Icon(
          Icons.logout,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
