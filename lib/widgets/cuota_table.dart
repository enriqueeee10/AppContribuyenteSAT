import 'package:flutter/material.dart';

class CuotaTable extends StatelessWidget {
  final List<Map<String, dynamic>> cuotas;
  final Map<int, bool> seleccionadas;
  final Function(int, bool) onSelectionChanged;
  final Function(bool) onSelectAll;

  const CuotaTable({
    super.key,
    required this.cuotas,
    required this.seleccionadas,
    required this.onSelectionChanged,
    required this.onSelectAll,
  });

  @override
  Widget build(BuildContext context) {
    bool allSelected = seleccionadas.values.every((isSelected) => isSelected);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTableTheme(
        data: DataTableThemeData(
          headingRowColor: WidgetStateColor.resolveWith(
              (states) => Colors.blue.shade100), // Color cabecera
          dataRowColor: WidgetStateColor.resolveWith((states) {
            return states.contains(WidgetState.selected)
                ? Colors.blue.withOpacity(0.2) // Fila seleccionada
                : Colors.white; // Fila normal
          }),
          dividerThickness: 1.2, // Grosor de las líneas divisorias
          headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        child: DataTable(
          columnSpacing: 10.0,
          columns: [
            DataColumn(
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
              ),
            ),
            DataColumn(label: Text("Cuota")),
            DataColumn(label: Text("Tributo")),
            DataColumn(label: Text("Vencimiento")),
            DataColumn(label: Text("Monto (S/.)")),
          ],
          rows: cuotas.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, dynamic> cuota = entry.value;
            double monto = cuota['insoluto'] +
                cuota['reajuste'] +
                cuota['interes'] +
                cuota['gasto'];

            return DataRow(
              selected: seleccionadas[index] ?? false,
              onSelectChanged: (value) {
                onSelectionChanged(index, value ?? false);
              },
              cells: [
                const DataCell(SizedBox()), // Se eliminó el checkbox duplicado
                DataCell(
                    Text("${cuota['cuota']}", style: TextStyle(fontSize: 14))),
                DataCell(Text("${cuota['nom_tributo']}",
                    style: TextStyle(fontSize: 14))),
                DataCell(Text("${cuota['fecha_vencimiento']}",
                    style: TextStyle(fontSize: 14))),
                DataCell(
                  Text(
                    "S/. ${monto.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
