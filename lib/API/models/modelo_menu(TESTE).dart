import 'modelo_tipoPlano.dart';
import 'modelo_aluno.dart';
import 'modelo_pessoa.dart';
import 'modelo_usuario.dart';

class MenuInicialResponse {
  final AlunoClass aluno;
  final PessoaClass pessoa;
  final TipoPlanoClass plano;
  final UsuarioClass usuario;

  MenuInicialResponse({
    required this.aluno,
    required this.pessoa,
    required this.plano,
    required this.usuario,
  });

  factory MenuInicialResponse.fromJson(Map<String, dynamic> json) {
    print("JSON Menu: $json");
    return MenuInicialResponse(
      aluno: AlunoClass.fromJson(json['Aluno']),
      pessoa: PessoaClass.fromJson(json['Pessoa']),
      plano: TipoPlanoClass.fromJson(json['Plano']),
      usuario: UsuarioClass.fromJson(json['Usuario']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Aluno': aluno.toJson(),
      'Pessoa': pessoa.toJson(),
      'Plano': plano.toJson(),
      'Usuario': usuario.toJson(),
    };
  }
}
