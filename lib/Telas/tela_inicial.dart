import 'package:projetosflutter/API/models/modelo_academia.dart';
import 'package:projetosflutter/API/models/modelo_pessoa.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';
import 'package:projetosflutter/Components/alerta.dart';
import 'package:flutter/material.dart';
import 'package:projetosflutter/Telas/menu_inicial.dart';
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

final Color lightOrange = const Color(0xFFFFF1E6);
final Color orange = const Color(0xFFFF8C42);
final Color grey = const Color(0xFF333333);

class _MyAppState extends State<TelaInicial> {
  late GenericController<UsuarioClass> _usuarioController;
  late GenericController<UsuarioClass> _loginController;
  late List<UsuarioClass> usuario = [];

  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);

  @override
  void initState() {
    super.initState();
    _usuarioController = GenericController<UsuarioClass>(
      endpoint: 'Usuario',
      fromJson: (json) => UsuarioClass.fromJson(json),
    );
    _loginController = GenericController(
      endpoint: 'Usuario/login',
      fromJson: (json) => UsuarioClass.fromJson(json),
    );
  }

  //Buscar todos os elementos.
  Future<void> _buscarUsuario() async {
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

  void FazendoLogin(String login, String senha) async {
    int? idUsuario = await _loginController.loginUsuario(login, senha);

    if (idUsuario != null) {
      print('Login OK! ID do usuário: $idUsuario');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuInicial(
            idUsuario: idUsuario,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Falha ao Login'),
          duration: Duration(seconds: 2),
        ),
      );
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
          backgroundColor: grey,
        ),
        body: Container(
          //Filtrando a cor com o RGB, modelando com o fromARGB, mas nao da pra pegar a cor, tem que pegar externa
          color: grey,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              // Vai ser da imagem
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    SizedBox(
                        height: 110,
                        width: 80,
                        child: Image.asset('Assets/logo-bb.png')),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'BLACK',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              height: 1,
                            ),
                          ),
                          const Text(
                            'BROTHERS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 55,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'ACADEMIA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27,
                        color: orange,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 41),
                  ],
                ),
              ),

              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 30.0, left: 25.0, right: 25.0),
                  child: SizedBox(
                    width: 330,
                    child: TextField(
                      controller: nomeUsuario,
                      decoration: InputDecoration(
                        hintText: 'Usuário',
                        hintStyle: const TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Poppins',
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.black45,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 26.0, bottom: 20.0, left: 15.0, right: 15.0),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
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
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'Poppins',
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.black45,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.only(
                            top: 26.0, bottom: 20.0, left: 15.0, right: 15.0),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  )),
              const SizedBox(height: 11),

              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 30.0,
                  ),
                  child: Text(
                    'Esqueceu sua senha?',
                    style: TextStyle(
                      color: orange,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 65),
                      backgroundColor: orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
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
                        FazendoLogin(usuarioInput, senhaInput);
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
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              //Para o botao e o Text para adicinar texto e TEXSTYLE para estilizaçao
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                // AJUSTE 1: Adicionei espaçamento no topo
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // AJUSTE 2: Centralizei o conteúdo na linha
                    children: [
                      const Text(
                        'Não tem uma conta? ',
                        style: TextStyle(
                          color: Colors.white54, // AJUSTE 3: Cor do texto
                          fontSize: 14,
                          fontFamily: 'Poppins'
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TelaInscricao()));
                        },
                        child: Text(
                          'Crie uma agora',
                          style: TextStyle(
                              color: orange,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
        floatingActionButton: const AlertaEntrar(text: 'Ola'),
      ),
    );
  }
}
