class Deuda {
  final String tipo;
  final double insoluto;
  final double reajuste;
  final double interes;
  final double gasto;
  final String nomTributo;

  Deuda({
    required this.tipo,
    required this.insoluto,
    required this.reajuste,
    required this.interes,
    required this.gasto,
    required this.nomTributo,
  });

  factory Deuda.fromJson(String tipo, Map<String, dynamic> json) {
    return Deuda(
      tipo: tipo,
      insoluto: (json['insoluto'] ?? json['deuda_normal']).toDouble(),
      reajuste: (json['reajuste'] ?? 0).toDouble(),
      interes: (json['interes'] ?? 0).toDouble(),
      gasto: (json['gasto'] ?? 0).toDouble(),
      nomTributo: json['nom_tributo'] ?? "Desconocido",
    );
  }
}
