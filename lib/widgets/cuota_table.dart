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
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: PaginatedDataTable(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Listado de Deudas",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              // Checkbox(
              //   value: allSelected,
              //   onChanged: (value) {
              //     onSelectAll(value ?? true);
              //   },
              // ),
            ],
          ),
          columns: const [
            DataColumn(label: Text("Cuota")),
            DataColumn(label: Text("Tributo")),
            DataColumn(label: Text("Vencimiento")),
            DataColumn(label: Text("Monto (S/.)")),
          ],
          source: _CuotaDataSource(cuotas, seleccionadas, onSelectionChanged),
          rowsPerPage: 4,
          availableRowsPerPage: const [4, 5, 10],
          showCheckboxColumn:
              true, // Usamos el checkbox personalizado en el header
        ),
      ),
    );
  }
}

class _CuotaDataSource extends DataTableSource {
  final List<Map<String, dynamic>> cuotas;
  final Map<int, bool> seleccionadas;
  final Function(int, bool) onSelectionChanged;

  _CuotaDataSource(this.cuotas, this.seleccionadas, this.onSelectionChanged);

  @override
  DataRow getRow(int index) {
    // ignore: null_check_always_fails
    if (index >= cuotas.length) return null!;
    final cuota = cuotas[index];

    double monto = (cuota['insoluto'] ?? 0) +
        (cuota['reajuste'] ?? 0) +
        (cuota['interes'] ?? 0) +
        (cuota['gasto'] ?? 0);

    return DataRow(
      selected: seleccionadas[index] ?? true,
      onSelectChanged: (value) {
        onSelectionChanged(index, value ?? true);
      },
      cells: [
        DataCell(
            Text("${cuota['cuota']}", style: const TextStyle(fontSize: 14))),
        DataCell(Text("${cuota['nom_tributo']}",
            style: const TextStyle(fontSize: 14))),
        DataCell(Text("${cuota['fecha_vencimiento']}",
            style: const TextStyle(fontSize: 14))),
        DataCell(
          Text(
            "S/. ${monto.toStringAsFixed(2)}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => cuotas.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => seleccionadas.values.where((s) => s).length;
}
