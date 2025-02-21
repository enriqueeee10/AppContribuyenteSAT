import 'package:flutter/material.dart';

class CuotaItem extends StatelessWidget {
  final Map<String, dynamic> cuota;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const CuotaItem({
    super.key,
    required this.cuota,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final monto = cuota['insoluto'] +
        cuota['reajuste'] +
        cuota['interes'] +
        cuota['gasto'];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      child: ListTile(
        leading: Checkbox(
            value: isSelected,
            onChanged: (bool? value) => onSelected(value ?? false)),
        title: Text(
          "Cuota ${cuota['cuota']} - ${cuota['nom_tributo']}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        subtitle: Text("Vence: ${cuota['fecha_vencimiento']}"),
        trailing: Text("S/. ${monto.toStringAsFixed(2)}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 230, 10, 10))),
      ),
    );
  }
}
