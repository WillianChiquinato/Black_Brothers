class AcademiaClass {
  final String CNPJ;
  final String nome;
  final int? FK_Endereco_ID;

  AcademiaClass({required this.CNPJ, required this.nome, this.FK_Endereco_ID});

  factory AcademiaClass.fromJson(Map<String, dynamic> json) {
    return AcademiaClass(
      CNPJ: json['CNPJ'] ?? -1,
      nome: json['Nome'] ?? '',
      FK_Endereco_ID: json['FK_Endereco_ID'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CNPJ': CNPJ,
      'Nome': nome,
      'FK_Endereco_ID': FK_Endereco_ID
    };
  }
}
