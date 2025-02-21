import 'package:flutter/material.dart';

class ContribuyenteCard extends StatelessWidget {
  final Map<String, dynamic> contribuyente;

  const ContribuyenteCard({super.key, required this.contribuyente});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 5,
      color: const Color.fromARGB(255, 233, 245, 234),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(contribuyente["Nombre"],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Código: ${contribuyente["cod_contribuyente"]}",
                style: TextStyle(fontSize: 14)),
            Text("Correo: ${contribuyente["correo_email"]}",
                style: TextStyle(fontSize: 14)),
            Text("Domicilio: ${contribuyente["DomicilioFiscal"]}",
                style: TextStyle(fontSize: 12)),
            Text("Calificación: ${contribuyente["calificacion"]}",
                style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 22, 124, 2),
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
