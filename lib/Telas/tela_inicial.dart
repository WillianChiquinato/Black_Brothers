import 'package:projetosflutter/API/models/modelo_academia.dart';
import 'package:projetosflutter/API/models/modelo_pessoa.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';
import 'package:projetosflutter/Components/alerta.dart';
import 'package:flutter/material.dart';
import 'package:projetosflutter/Telas/menu_inicial.dart';
import 'package:projetosflutter/Telas/tela_Inscricao.dart';
import '../API/controller.dart';
import '../Components/ToastMessage.dart';

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

  Future<int?> FazendoLogin(String login, String senha) async {
    print('LOGIN: $login, SENHA: $senha');

    if (login == null || login.isEmpty || senha == null || senha.isEmpty) {
      Future.delayed(const Duration(milliseconds: 200), () {
        showToast(context, "Preencha todos os campos!", type: ToastType.error);
      });
      return null;
    }

    int? idUsuario = await _loginController.loginUsuario(login, senha);
    print("JSON: $idUsuario");

    if (idUsuario != null) {
      print('Login OK! ID do usuário: $idUsuario');
      showToast(context, "Usuário encontrado!", type: ToastType.success);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MenuInicial(
                  idUsuario: idUsuario,
                ),
          ),
        );
      });
    } else {
      showToast(context, "Usuário nao encontrado!", type: ToastType.error);
    }
  }

  bool _obscuraSenha = true;
  bool buttonPress = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final horizontalPadding = screenWidth * 0.06;
    final logoHeight = screenHeight * 0.14;
    final logoWidth = screenWidth * 0.20;
    final titleFontSize = screenWidth * 0.13;
    final subtitleFontSize = screenWidth * 0.065;
    final fieldHeight = screenHeight * 0.075;
    final buttonHeight = screenHeight * 0.08;
    final smallTextSize = screenWidth * 0.035;
    final buttonFontSize = screenWidth * 0.05;
    final fieldContentVerticalPadding = fieldHeight * 0.35;
    final fieldContentHorizontalPadding = screenWidth * 0.04;

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
          toolbarHeight: screenHeight * 0.05,
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
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    SizedBox(
                        height: logoHeight,
                        width: logoWidth,
                        child: Image.asset('Assets/logo-bb.png')),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BLACK',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              height: 1,
                            ),
                          ),
                          Text(
                            'BROTHERS',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),

                    Text(
                      'ACADEMIA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: subtitleFontSize,
                        color: orange,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(
                      bottom: screenHeight * 0.03,
                      left: horizontalPadding,
                      right: horizontalPadding),
                  child: SizedBox(
                    width: screenWidth * 0.88,
                    child: TextField(
                      controller: nomeUsuario,
                      decoration: InputDecoration(
                        hintText: 'Usuário',
                        hintStyle: TextStyle(
                          fontSize: smallTextSize + 2,
                          fontFamily: 'Poppins',
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.black45,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(
                            top: fieldContentVerticalPadding,
                            bottom: fieldContentVerticalPadding,
                            left: fieldContentHorizontalPadding,
                            right: fieldContentHorizontalPadding),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: screenHeight * 0.01,
                      left: horizontalPadding,
                      right: horizontalPadding),
                  child: SizedBox(
                    width: screenWidth * 0.88,
                    child: TextField(
                      controller: nomeSenha,
                      obscureText: _obscuraSenha,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                        hintStyle: TextStyle(
                          fontSize: smallTextSize + 2,
                          fontFamily: 'Poppins',
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.black45,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscuraSenha ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscuraSenha = !_obscuraSenha;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.only(
                            top: fieldContentVerticalPadding,
                            bottom: fieldContentVerticalPadding,
                            left: fieldContentHorizontalPadding,
                            right: fieldContentHorizontalPadding),
                      ),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  )),
              SizedBox(height: screenHeight * 0.015),

              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.015,
                    bottom: screenHeight * 0.04,
                  ),
                  child: Text(
                    'Esqueceu sua senha?',
                    style: TextStyle(
                      color: orange,
                      fontSize: smallTextSize,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(screenWidth * 0.88, buttonHeight),
                      backgroundColor: orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () async {
                      final usuarioInput = nomeUsuario.text.trim();
                      final senhaInput = nomeSenha.text.trim();

                      // Chama a função de login que envia dados para a API.
                      if (usuarioInput != null && senhaInput != null) {
                        await FazendoLogin(usuarioInput, senhaInput);
                      }
                    },
                    child: Text(
                      'ENTRAR',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: buttonFontSize,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              //Para o botao e o Text para adicinar texto e TEXSTYLE para estilizaçao
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.035),
                child:
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Não tem uma conta? ',
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: smallTextSize,
                        fontFamily: 'Poppins'),
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
                          fontSize: smallTextSize,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: screenHeight * 0.08),
            ],
          ),
        ),
        floatingActionButton: const AlertaEntrar(text: 'Whatsapp'),
      ),
    );
  }
}