class TreinoClass {
  final int id;
  final String nome;
  final int FK_Instrutor_ID;
  final int FK_Aluno_ID;

  TreinoClass(
      {required this.id,
        required this.nome,
        required this.FK_Instrutor_ID,
        required this.FK_Aluno_ID});

  factory TreinoClass.fromJson(Map<String, dynamic> json) {
    return TreinoClass(
      id: int.tryParse(json['ID_Treino']?.toString() ?? '') ?? -1,
      nome: json['Nome'] ?? '',
      FK_Instrutor_ID: int.tryParse(json['FK_Empregado_ID']?.toString() ?? '') ?? -1,
      FK_Aluno_ID: int.tryParse(json['FK_Aluno_ID']?.toString() ?? '') ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'Nome': nome,
      'FK_Empregado_ID': FK_Instrutor_ID,
      'FK_Aluno_ID': FK_Aluno_ID,
    };

    return data;
  }
}
