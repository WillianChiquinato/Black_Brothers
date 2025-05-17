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
      Matricula: json['Matricula'] ?? -1,
      FK_Usuarios_ID: json['FK_Usuario_ID'] ?? '',
      FK_Planos_ID: json['FK_Planos_ID'] ?? '',
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