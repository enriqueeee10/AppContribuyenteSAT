import 'package:flutter/material.dart';

class DetalleDeudaNormal extends StatelessWidget {
  final List<dynamic> deudaNormalLista;

  const DetalleDeudaNormal(this.deudaNormalLista, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Detalle de Deuda Normal",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...deudaNormalLista.map((deuda) {
            return ListTile(
              title: Text(deuda['descripcion_grupo'] ?? "Sin descripción"),
              subtitle: Text(
                  "Monto: S/. ${deuda['deuda_normal'].toStringAsFixed(2)}"),
            );
          }),
        ],
      ),
    );
  }
}
