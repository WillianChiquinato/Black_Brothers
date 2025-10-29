class FrequenciaClass {
  final int id;
  final String nome;
  final String dataCriacao;
  final int duracao;
  final int FK_Aluno_ID;
  final int FK_TreinoExercicio_ID;

  FrequenciaClass(
      {required this.id,
      required this.nome,
      required this.dataCriacao,
      required this.duracao,
      required this.FK_Aluno_ID,
      required this.FK_TreinoExercicio_ID});

  factory FrequenciaClass.fromJson(Map<String, dynamic> json) {
    return FrequenciaClass(
      id: int.tryParse(json['ID']?.toString() ?? '') ?? -1,
      nome: json['Nome_Frequencia'] ?? '',
      dataCriacao: json['CreatedAt'] ?? '',
      duracao: int.tryParse(json['Duracao']?.toString() ?? '') ?? -1,
      FK_Aluno_ID: int.tryParse(json['FK_Aluno_ID']?.toString() ?? '') ?? -1,
      FK_TreinoExercicio_ID:
          int.tryParse(json['FK_TreinoExercicio_ID']?.toString() ?? '') ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'Nome_Frequencia': nome,
      'CreatedAt': dataCriacao,
      'Duracao': duracao,
      'FK_Aluno_ID': FK_Aluno_ID,
      'FK_TreinoExercicio_ID': FK_TreinoExercicio_ID
    };

    return data;
  }
}
