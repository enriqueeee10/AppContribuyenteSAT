import 'package:flutter/material.dart';
import 'package:flutter_application_rest/services/api_service.dart';
import 'package:flutter_application_rest/widgets/modal_detalle_deuda.dart';
import '../widgets/detalle_deuda_normal.dart';

class DeudaScreen extends StatefulWidget {
  final String email;
  final String codigo;

  const DeudaScreen({super.key, required this.email, required this.codigo});

  @override
  _DeudaScreenState createState() => _DeudaScreenState();
}

class _DeudaScreenState extends State<DeudaScreen> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? contribuyente;
  List<Map<String, dynamic>> deudas = [];
  String errorMessage = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final data =
        await _apiService.fetchContribuyente(widget.email, widget.codigo);

    if (data != null) {
      setState(() {
        contribuyente = {
          "cod_contribuyente": data['cod_contribuyente'],
          "Nombre": data['Nombre'],
          "correo_email": data['correo_email'],
          "DomicilioFiscal": data['DomicilioFiscal'],
          "calificacion": data['calificacion']
        };

        // ✅ Depuración: Ver qué datos llegan antes de la suma
        List<dynamic> deudaNormalLista =
            data['deuda_normal_agrupado_json'] ?? [];
        print("Lista de deuda normal: $deudaNormalLista");

        double totalDeudaNormal = 0.0;

        for (var deuda in deudaNormalLista) {
          double monto = (deuda['insoluto'] ?? 0).toDouble();
          print("Monto individual: $monto"); // <-- Imprimir cada monto
          totalDeudaNormal += monto;
        }

        print("Total de Deuda Normal: $totalDeudaNormal");

        deudas = [
          {
            "tipo": "Deuda Normal",
            "total": totalDeudaNormal, // ✅ Total de todas las deudas normales
            "detalles":
                deudaNormalLista // ✅ Lista completa para mostrar en el modal
          },
          {
            "tipo": "Deuda Pronto Pago",
            "total": data['deudas_pronto_pago_json'][0]['insoluto'] ?? 0,
            "detalles": data['deudas_pronto_pago_json'][0]
          },
          {
            "tipo": "Deuda Pago Puntual",
            "total": data['deudas_pago_puntual_json'][0]['insoluto'] ?? 0,
            "detalles": data['deudas_pago_puntual_json'][0]
          },
          {
            "tipo": "Deuda General",
            "total": data['deudas_json'][0]['insoluto'] ?? 0,
            "detalles": data['deudas_json'][0]
          },
        ];

        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = "Datos incorrectos";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deudas")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // 📌 CARD DEL CONTRIBUYENTE
                      Card(
                        margin: EdgeInsets.all(16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Información del Contribuyente",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 8),
                              Center(
                                child: Text(
                                    "${contribuyente?['Nombre'] ?? 'Desconocido'}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ),
                              Text(
                                  "Email: ${contribuyente?['correo_email'] ?? 'No registrado'}",
                                  style: TextStyle(color: Colors.black)),
                              Text(
                                  "Dirección: ${contribuyente?['DomicilioFiscal'] ?? 'No disponible'}",
                                  style: TextStyle(color: Colors.black)),
                              Center(
                                child: Text(
                                    "Calificación: ${contribuyente?['calificacion'] ?? 'No asignado'}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 📌 LISTA DE DEUDAS
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: deudas.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (deudas[index]['tipo'] == "Deuda Normal") {
                                // 📌 Muestra los detalles completos de la Deuda Normal
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => DetalleDeudaNormal(
                                      deudas[index]['detalles']),
                                );
                              } else {
                                // 📌 Muestra el modal estándar para las demás deudas
                                showDialog(
                                  context: context,
                                  builder: (context) => ModalDetalleDeuda(
                                      deuda: deudas[index]['detalles']),
                                );
                              }
                            },
                            child: Card(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 4,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: ListTile(
                                title: Text(
                                  deudas[index]['tipo'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Monto: S/. ${deudas[index]['total'].toStringAsFixed(2)}",
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: Colors.green,
        child: Icon(Icons.logout),
      ),
    );
  }
}
