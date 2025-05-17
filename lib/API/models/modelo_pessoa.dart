class PessoaClass {
  final String CPF;
  final String Nome;
  final String Email;
  final String DtNasc;
  final String FK_Academia_ID;

  PessoaClass(
      {required this.CPF,
      required this.Nome,
      required this.Email,
      required this.DtNasc,
      required this.FK_Academia_ID});

  factory PessoaClass.fromJson(Map<String, dynamic> json) {
    return PessoaClass(
      CPF: json['CPF'] ?? -1,
      Nome: json['Nome'] ?? '',
      Email: json['Email'] ?? '',
      DtNasc: json['DtNasc'] ?? '',
      FK_Academia_ID: json['FK_Academia_ID'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CPF': CPF,
      'Nome': Nome,
      'Email': Email,
      'DtNasc': DtNasc,
      'FK_Academia_ID': FK_Academia_ID
    };
  }
}
