class TipoTelefoneClass {
  final int id;
  final String descricao;

  TipoTelefoneClass({required this.id, required this.descricao});

  factory TipoTelefoneClass.fromJson(Map<String, dynamic> json) {
    return TipoTelefoneClass(
        id: int.tryParse(json['ID_TipoTEL']?.toString() ?? '') ?? -1,
        descricao: json['Descricao'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_TipoTEL': id,
      'Descricao': descricao,
    };
  }
}
