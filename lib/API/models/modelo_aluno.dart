class AlunoClass {
  final int? Matricula;
  final int FK_Usuarios_ID;
  final int FK_Planos_ID;

  AlunoClass(
      {this.Matricula,
      required this.FK_Usuarios_ID,
      required this.FK_Planos_ID});

  factory AlunoClass.fromJson(Map<String, dynamic> json) {
    return AlunoClass(
      Matricula: int.tryParse(json['Matricula']?.toString() ?? '') ?? -1,
      FK_Usuarios_ID: json['FK_Usuario_ID'] is int
          ? json['FK_Usuario_ID']
          : int.tryParse(json['FK_Usuario_ID']?.toString() ?? '') ?? 0,
      FK_Planos_ID: json['FK_Planos_ID'] is int
          ? json['FK_Planos_ID']
          : int.tryParse(json['FK_Planos_ID']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Matricula': Matricula,
      'FK_Usuario_ID': FK_Usuarios_ID,
      'FK_Planos_ID': FK_Planos_ID
    };
  }
}
