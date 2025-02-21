import 'package:flutter/material.dart';

class ModalDetalleDeuda extends StatelessWidget {
  final Map<String, dynamic> deuda;

  const ModalDetalleDeuda({super.key, required this.deuda});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Detalles de la Deuda"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Tributo: ${deuda['nom_tributo'] ?? 'Desconocido'}"),
          Text("Insoluto: S/. ${deuda['insoluto'] ?? 0}"),
          Text("Reajuste: S/. ${deuda['reajuste'] ?? 0}"),
          Text("Interés: S/. ${deuda['interes'] ?? 0}"),
          Text("Gasto: S/. ${deuda['gasto'] ?? 0}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cerrar"),
        ),
      ],
    );
  }
}
