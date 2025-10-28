class TreinoExercicioClass {
  final int id;
  final int FK_Treino_ID;
  final int FK_Exercicio_ID;

  TreinoExercicioClass(
      {required this.id,
        required this.FK_Treino_ID,
        required this.FK_Exercicio_ID});

  factory TreinoExercicioClass.fromJson(Map<String, dynamic> json) {
    return TreinoExercicioClass(
      id: int.tryParse(json['id']?.toString() ?? '') ?? -1,
      FK_Treino_ID: int.tryParse(json['FK_Treino_ID']?.toString() ?? '') ?? -1,
      FK_Exercicio_ID: int.tryParse(json['FK_Exercicio_ID']?.toString() ?? '') ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'FK_Treino_ID': FK_Treino_ID,
      'FK_Exercicio_ID': FK_Exercicio_ID
    };

    return data;
  }
}
