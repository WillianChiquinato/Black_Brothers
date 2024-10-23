//Base do modelo que vamos pegar do MOCK;
class UserClass {
  int? id;
  String? nome;
  int? idade;
  String? plano;

  UserClass({this.id, this.nome, this.idade, this.plano});

  UserClass.fromJson(Map<String, dynamic> json) {
    id = json['id'] is String ? int.tryParse(json['id']) : json['id'];
    nome = json['Nome'];
    idade = json['Idade'];
    plano = json['Plano'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['Nome'] = nome;
    data['Idade'] = idade;
    data['Plano'] = plano;
    return data;
  }
}
