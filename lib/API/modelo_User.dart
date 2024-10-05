//Base do modelo que vamos pegar do MOCK;
class UserClass {
  int? id;
  String? nome;
  int? idade;
  String? plano;

  UserClass({this.id, this.nome, this.idade, this.plano});

  UserClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    idade = json['idade'];
    plano = json['plano'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['idade'] = this.idade;
    data['plano'] = this.plano;
    return data;
  }
}
