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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Nome'] = this.nome;
    data['Idade'] = this.idade;
    data['Plano'] = this.plano;
    return data;
  }
}
