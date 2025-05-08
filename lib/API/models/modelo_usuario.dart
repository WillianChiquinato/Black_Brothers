//Modelo de USUARIO
class UsuarioClass {
  final int? id;
  final String login;
  final String senha;
  final String fK_Pessoa_ID;

  UsuarioClass(
      {this.id,
      required this.login,
      required this.senha,
      required this.fK_Pessoa_ID});

  factory UsuarioClass.fromJson(Map<String, dynamic> json) {
    return UsuarioClass(
      id: json['ID_Usuario'],
      login: json['Login'] ?? '',
      senha: json['Senha'] ?? '',
      fK_Pessoa_ID: json['FK_Pessoa_ID']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'Login': login,
      'Senha': senha,
      'FK_Pessoa_ID': fK_Pessoa_ID,
    };

    if (id != null) {
      data['ID_Usuario'] = id as String;
    }

    return data;
  }
}
