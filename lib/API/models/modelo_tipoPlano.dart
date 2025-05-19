class TipoPlanoClass {
  final int? id;
  final String nomePlano;
  final int precoPlano;
  final String beneficiosPlano;

  TipoPlanoClass(
      {this.id,
      required this.nomePlano,
      required this.precoPlano,
      required this.beneficiosPlano});

  factory TipoPlanoClass.fromJson(Map<String, dynamic> json) {
    return TipoPlanoClass(
        id: int.tryParse(json['ID_TipoPlanos']?.toString() ?? '') ?? -1,
        nomePlano: json['Nome'] ?? '',
        precoPlano: int.tryParse(json['Preco']?.toString() ?? '') ?? -1,
        beneficiosPlano: json['Beneficios'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_TipoPlanos': id,
      'Nome': nomePlano,
      'Preco': precoPlano,
      'Beneficios': beneficiosPlano,
    };
  }
}
