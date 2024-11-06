//Base do modelo que vamos pegar do MOCK;
class UserClass {
  String? id;
  String? nome;
  String? idade;
  String? plano;

  UserClass({this.id, this.nome, this.idade, this.plano});

  UserClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    idade = json['idade'];
    plano = json['plano'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['idade'] = idade;
    data['plano'] = plano;
    return data;
  }
}
