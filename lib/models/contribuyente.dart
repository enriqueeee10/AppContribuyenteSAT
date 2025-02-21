class Contribuyente {
  final String codigo;
  final String nombre;
  final String correo;
  final String domicilio;
  final String calificacion;

  Contribuyente({
    required this.codigo,
    required this.nombre,
    required this.correo,
    required this.domicilio,
    required this.calificacion,
  });

  factory Contribuyente.fromJson(Map<String, dynamic> json) {
    return Contribuyente(
      codigo: json['cod_contribuyente'],
      nombre: json['Nombre'],
      correo: json['correo_email'],
      domicilio: json['DomicilioFiscal'],
      calificacion: json['calificacion'],
    );
  }

  // ✅ Método toJson para convertirlo a Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'cod_contribuyente': codigo,
      'Nombre': nombre,
      'correo_email': correo,
      'DomicilioFiscal': domicilio,
      'calificacion': calificacion,
    };
  }
}
