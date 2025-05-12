import 'package:projetosflutter/API/models/modelo_academia.dart';
import 'package:projetosflutter/API/models/modelo_pessoa.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';
import 'package:projetosflutter/Components/alerta.dart';
import 'package:flutter/material.dart';
import 'package:projetosflutter/Telas/tela_Inscricao.dart';
import '../API/controller.dart';

//StatelessWidget para tarefas repetitivas.
//Estatico, sem mudanca de valores, sem atualizar na tela
class TelaInicial extends StatefulWidget {
  const TelaInicial({
    super.key,
  });

  @override
  State<TelaInicial> createState() => _MyAppState();
}

final TextEditingController nomeUsuario = TextEditingController();
final TextEditingController nomeSenha = TextEditingController();

class _MyAppState extends State<TelaInicial> {
  late GenericController<AcademiaClass> _academiaController;
  late List<AcademiaClass> academia = [];

  late GenericController<PessoClass> _pessoaController;
  late List<PessoClass> pessoa = [];

  late GenericController<UsuarioClass> _usuarioController;
  late List<UsuarioClass> usuario = [];

  @override
  void initState() {
    super.initState();
    _usuarioController = GenericController<UsuarioClass>(
      endpoint: 'usuario',
      fromJson: (json) => UsuarioClass.fromJson(json),
    );

    _academiaController = GenericController<AcademiaClass>(
      endpoint: 'academia',
      fromJson: (json) => AcademiaClass.fromJson(json),
    );

    _pessoaController = GenericController(
      endpoint: 'pessoa',
      fromJson: (json) => PessoClass.fromJson(json),
    );
  }

  //Buscar um elemento so.
  Future<void> _buscarUsuario() async {
    print('Chamando getOne com ID 0');
    var resultado = await _usuarioController.getAll();
    if (resultado != null) {
      print('Usuário encontrado: ${resultado}');
      setState(() {
        usuario = resultado;
      });
    } else {
      print("Usuário com ID não encontrado.");
    }
  }

  //Criar CNPJ Academia
  Future<void> _criarCNPJ() async {
    Map<String, dynamic> data = {
      'CNPJ': '13.000.000.0',
      'Nome': 'Black Brothers',
      'FK_Academia_ID': null
    };

    var resultado = await _academiaController.create(data);
    if (resultado != null) {
      setState(() {
        academia = [resultado];
      });
      print('Academia criada com sucesso');
    } else {
      print('Academia nao criada, FALHA!!');
    }
  }

  //Criar Pessoa
  Future<void> _criarPessoa() async {
    Map<String, dynamic> data = {
      'CPF': '40457284811',
      'Nome': 'Willian',
      'Email': 'WillianChiquinato@hotmail.com',
      'DtNasc': '16/07/2004',
      'FK_Academia_ID': '13000'
    };

    var resultado = await _pessoaController.create(data);
    if (resultado != null) {
      setState(() {
        pessoa = [resultado];
      });
      print('Pessoa criada com sucesso!!');
    } else {
      print('Não existe academia disponivel');
    }
  }

  //Update Pessoa.
  Future<void> _updatePessoa() async {
    Map<String, dynamic> novosDados = {
      'CPF': '232253463',
    };

    var resultado = await _pessoaController.update('0', novosDados);

    if (resultado != null) {
      setState(() {
        pessoa = [resultado];
      });
      print("Pessoa atualizada");
    } else {
      print("Erro ao atualizar pessoa");
    }
  }

  //Criar usuário.
  Future<void> _criarUsuario() async {
    Map<String, dynamic> data = {
      'Login': nomeUsuario.text.trim(),
      'Senha': nomeSenha.text.trim(),
      'FK_Pessoa_ID': 232253463
    };

    print('Dados enviados: $data');

    var resultado = await _usuarioController.create(data);
    if (resultado != null) {
      setState(() {
        usuario = [resultado];
      });
      print('Usuario criada com sucesso!!');
    } else {
      print('Não existe usuario disponivel');
    }
  }

  final bool _obscuraSenha = true;
  bool buttonPress = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'BlackBrothers',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //Home é o nosso BODY no Flutter.
      //Stack, empilhar uma em cima da outra.,
      //Um em cima do outro com stack, literalmente em forma de pilha
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: const Color.fromARGB(255, 210, 125, 43),
        ),
        body: Container(
          //Filtrando a cor com o RGB, modelando com o fromARGB, mas nao da pra pegar a cor, tem que pegar externa
          color: const Color.fromARGB(255, 210, 125, 43),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              // Vai ser da imagem
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                  color: Colors.transparent,
                  height: 140,
                  width: 140,
                  child: Image.asset('Assets/Black_Brother.png',
                      fit: BoxFit.cover),
                ),
              ),

              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 30.0, left: 25.0, right: 25.0),
                  child: SizedBox(
                    width: 330,
                    child: TextField(
                      controller: nomeUsuario,
                      decoration: const InputDecoration(
                        hintText: 'USUÁRIO',
                        hintStyle: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'PadraoLoginBB',
                        ),
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 26.0, bottom: 20.0, left: 15.0, right: 15.0),
                      ),
                      style: const TextStyle(fontFamily: 'PadraoLoginBB'),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 6.0, left: 25.0, right: 25.0),
                  child: SizedBox(
                    width: 330,
                    child: TextField(
                      controller: nomeSenha,
                      obscureText: _obscuraSenha,
                      decoration: const InputDecoration(
                        hintText: 'SENHA',
                        hintStyle: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'PadraoLoginBB',
                        ),
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 26.0, bottom: 20.0, left: 15.0, right: 15.0),
                      ),
                      style: const TextStyle(fontFamily: 'PadraoLoginBB'),
                    ),
                  )),
              Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 65),
                      backgroundColor: const Color.fromARGB(255, 88, 48, 11),
                    ),
                    onPressed: () async {
                      await _buscarUsuario();

                      final usuarioInput = nomeUsuario.text.trim();
                      final senhaInput = nomeSenha.text.trim();

                      final usuarioEncontrado = usuario.firstWhere(
                        (u) =>
                            u != null &&
                            u.login == usuarioInput &&
                            u.senha == senhaInput,
                        orElse: () => UsuarioClass(
                          id: -1,
                          login: '',
                          senha: '',
                          fK_Pessoa_ID: '',
                        ),
                      );

                      if (usuarioEncontrado != null &&
                          usuarioEncontrado.id != -1) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Bem-vindo!"),
                            content: Text(
                                "Olá, ${usuarioEncontrado.login}! Você entrou com sucesso.\nSenha: ${usuarioEncontrado.senha}"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              )
                            ],
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Usuário ou senha inválidos'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'ENTRAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                color: const Color.fromARGB(255, 210, 125, 43),
                height: 50,
                width: double.infinity,
                child: const Row(
                  children: [
                    // Linha à esquerda
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                        indent: 30, // Espaçamento da borda esquerda
                        endIndent: 10, // Espaçamento antes do texto
                      ),
                    ),
                    Text(
                      'OU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Linha à direita
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        thickness: 2,
                        indent: 10, // Espaçamento antes do texto
                        endIndent: 30, // Espaçamento da borda direita
                      ),
                    ),
                  ],
                ),
              ),
              //Para o botao e o Text para adicinar texto e TEXSTYLE para estilizaçao
              Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                  //Vai para telaIncricao();
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 65),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 234, 209)),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const TelaInscricao()));

                      final usuarioInput = nomeUsuario.text.trim();
                      final senhaInput = nomeSenha.text.trim();

                      if (usuarioInput.isEmpty || senhaInput.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Preencha login e senha'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      else
                      {
                        await _criarUsuario();
                      }
                    },
                    child: const Text(
                      'Inscrever-se',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: const AlertaEntrar(text: 'Ola'),
      ),
    );
  }
}
