class InstrutorClass {
  final int id;
  final int cargaHoraria;
  final double salario;
  final String descricao;
  final int FK_Usuario_ID;
  final int FK_Cargo_ID;

  InstrutorClass({
    required this.id,
    required this.cargaHoraria,
    required this.salario,
    required this.descricao,
    required this.FK_Usuario_ID,
    required this.FK_Cargo_ID,
  });

  factory InstrutorClass.fromJson(Map<String, dynamic> json) {
    return InstrutorClass(
      id: int.tryParse(json['ID_Empregado']?.toString() ?? '') ?? -1,
      cargaHoraria: int.tryParse(json['Carga_Horaria']?.toString() ?? '') ?? -1,
      salario: double.tryParse(json['Salario']?.toString() ?? '') ?? 0.0,
      descricao: json['Descricao'] ?? '',
      FK_Usuario_ID: int.tryParse(json['FK_Usuario_ID']?.toString() ?? '') ?? -1,
      FK_Cargo_ID: int.tryParse(json['FK_Cargo_ID']?.toString() ?? '') ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'Carga_Horaria': cargaHoraria,
      'Salario': salario,
      'Descricao': descricao,
      'FK_Usuario_ID': FK_Usuario_ID,
      'FK_Cargo_ID': FK_Cargo_ID
    };

    return data;
  }
}
