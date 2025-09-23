class AlunoClass {
  final int Matricula;
  final int FK_Usuarios_ID;
  final int FK_Planos_ID;
  final double? Altura;
  final double? Peso;

  AlunoClass(
      {required this.Matricula,
      required this.FK_Usuarios_ID,
      required this.FK_Planos_ID,
      this.Altura,
      this.Peso});

  factory AlunoClass.fromJson(Map<String, dynamic> json) {
    double? parseDouble(dynamic v) {
      if (v == null) return null;
      if (v is num) return v.toDouble();
      if (v is String && v.isNotEmpty) return double.tryParse(v);
      return null;
    }

    return AlunoClass(
      Matricula: json['Matricula'] ?? 0,
      FK_Usuarios_ID: json['FK_Usuario_ID'],
      FK_Planos_ID: json['FK_Planos_ID'],
      Altura: parseDouble(json['altura']),
      Peso: parseDouble(json['peso']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Matricula': Matricula,
      'FK_Usuario_ID': FK_Usuarios_ID,
      'FK_Planos_ID': FK_Planos_ID,
      'altura': Altura,
      'peso': Peso
    };
  }
}
