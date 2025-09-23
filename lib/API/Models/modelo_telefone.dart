class TelefoneClass {
  final int id;
  final String Telefone;
  final String? Telefone2;
  final String FK_CPF;
  final int FK_TipoTel_ID;

  TelefoneClass(
      {required this.id,
      required this.Telefone,
      required this.Telefone2,
      required this.FK_CPF,
      required this.FK_TipoTel_ID});

  factory TelefoneClass.fromJson(Map<String, dynamic> json) {
    return TelefoneClass(
      id: int.tryParse(json['ID_Telefone']?.toString() ?? '') ?? -1,
      Telefone: json['Telefone01'] ?? '',
      Telefone2: json['Telefone02'] ?? '',
      FK_CPF: json['FK_CPF'] ?? '',
      FK_TipoTel_ID:
          int.tryParse(json['FK_TipoTel_ID']?.toString() ?? '') ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID_Telefone': id,
      'Telefone01': Telefone,
      'Telefone02': Telefone2,
      'FK_CPF': FK_CPF,
      'FK_TipoTel_ID': FK_TipoTel_ID,
    };
  }
}
