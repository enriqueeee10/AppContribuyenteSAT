import 'package:flutter/material.dart';

class TotalPagar extends StatelessWidget {
  final double montoTotal;

  const TotalPagar({super.key, required this.montoTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Total a pagar: S/. ${montoTotal.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ElevatedButton(
          onPressed: montoTotal > 0
              ? () {
                  // Lógica para pagar la deuda
                }
              : null,
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 54, 226, 45),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          child: Text("Pagar"),
        )
      ],
    );
  }
}
