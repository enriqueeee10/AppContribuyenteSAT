import 'package:flutter/material.dart';

class MultasBusquedaScreen extends StatefulWidget {
  @override
  _MultasBusquedaScreenState createState() => _MultasBusquedaScreenState();
}

class _MultasBusquedaScreenState extends State<MultasBusquedaScreen> {
  final _placaController = TextEditingController();
  bool _isLoading = false;
  Map<String, dynamic> _resultados = {};

  void _buscarMultas() async {
    setState(() {
      _isLoading = true;
      _resultados = {};
    });

    // Simulando una búsqueda (reemplazar con llamada a la API)
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      // Reemplazar con los datos reales de la API
      _resultados = {
        'deuda': 'S/ 150.00',
        'fecha': '2023-10-26',
        'descripcion': 'Exceso de velocidad',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alinea el texto a la izquierda
              children: [
                Text(
                  'Consulta de Multa Vehicular',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10), // Espacio entre el texto y el buscador
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _placaController,
                        decoration: InputDecoration(
                          hintText: 'Ingrese su placa',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.motorcycle_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _placaController.clear();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _buscarMultas,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.blue.shade900)
                          : Icon(
                              Icons.search,
                              color: Colors
                                  .white, // Especifica el color blanco para el icono
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                color: Colors.blue.shade900,
                child: Row(),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _resultados.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Deuda: ${_resultados['deuda']}'),
                        Text('Fecha: ${_resultados['fecha']}'),
                        Text('Descripción: ${_resultados['descripcion']}'),
                      ],
                    )
                  : Center(
                      child: Text(
                          _isLoading
                              ? 'Buscando...'
                              : 'Ingrese la placa para buscar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold) // Cambia el color a blanco
                          ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
