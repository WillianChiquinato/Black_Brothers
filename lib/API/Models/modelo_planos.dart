class PlanoClass {
  final int? id;
  final int Fk_Usuario_ID;
  final int Fk_TipoPlano_ID;

  PlanoClass(
      {this.id, required this.Fk_Usuario_ID, required this.Fk_TipoPlano_ID});

  factory PlanoClass.fromJson(Map<String, dynamic> json) {
    return PlanoClass(
        id: int.tryParse(json['ID_Planos']?.toString() ?? '') ?? -1,
        Fk_Usuario_ID:
            int.tryParse(json['FK_Usuario_ID']?.toString() ?? '') ?? -1,
        Fk_TipoPlano_ID:
            int.tryParse(json['FK_TipoPlano_ID']?.toString() ?? '') ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_Planos': id,
      'FK_Usuario_ID': Fk_Usuario_ID,
      'FK_TipoPlano_ID': Fk_TipoPlano_ID,
    };
  }
}
