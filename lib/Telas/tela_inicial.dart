import 'package:projetosflutter/Components/alerta.dart';
import 'package:flutter/material.dart';
import 'package:projetosflutter/Telas/tela_Inscricao.dart';
import '../API/card_entrada.dart';
import '../API/controller.dart';
import '../API/modelo_user.dart';

void main() {
  runApp(const TelaInicial());
}

//StatelessWidget para tarefas repetitivas.
//Estatico, sem mudanca de valores, sem atualizar na tela
class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _MyAppState();
}

final TextEditingController nomeUsuario = TextEditingController();
final UserController userController = UserController();

class _MyAppState extends State<TelaInicial> {
  @override
  void initState() {
    userController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  final TextEditingController nomeSenha = TextEditingController();
  final bool _obscuraSenha = true;

  String _usuario = "";
  String _senha = "";

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
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: const Color.fromARGB(255, 168, 88, 9),
        ),
        body: Container(
          //Filtrando a cor com o RGB, modelando com o fromARGB, mas nao da pra pegar a cor, tem que pegar externa
          color: const Color.fromARGB(255, 168, 88, 9),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              // Vai ser da imagem
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                  color: Colors.transparent,
                  height: 170,
                  width: 170,
                  child: Image.asset('Assets/Black_Brother.png',
                      fit: BoxFit.cover),
                ),
              ),

              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 35.0, left: 25.0, right: 25.0),
                  child: SizedBox(
                    width: 330,
                    height: 60,
                    child: TextField(
                      controller: nomeUsuario,
                      decoration: const InputDecoration(
                        hintText: 'Usuario',
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                      bottom: 35.0, left: 25.0, right: 25.0),
                  child: SizedBox(
                    width: 330,
                    height: 60,
                    child: TextField(
                      controller: nomeSenha,
                      obscureText: _obscuraSenha,
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                        filled: true,
                        fillColor: Colors.white70,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(300, 50),
                    backgroundColor: const Color.fromARGB(255, 77, 37, 0),
                  ),
                  onPressed: () {
                    //Incluindo a API em uma pequena verificação do usuario;
                    if (nomeUsuario.text.length < 50) {
                      userController.searchApi(user: nomeUsuario.text);
                    } else {
                      const snackBar =
                          SnackBar(content: Text('O nome esta muito grande'));

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    setState(() {
                      _usuario = nomeUsuario.text;
                      _senha = nomeSenha.text;
                      print('Usuario: ' + _usuario);
                      print('Senha: ' + _senha);
                    });
                  },
                  child: const Text(
                    'ENTRAR',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Widget que observa e reage às mudanças de isLoading e UserAddress
              Column(
                children: [
                  // Exibe o CircularProgressIndicator enquanto está carregando
                  ValueListenableBuilder<bool>(
                    valueListenable: userController.isLoading,
                    builder: (context, isLoading, child) {
                      return Visibility(
                        visible: isLoading,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),

                  ValueListenableBuilder<UserClass?>(
                    valueListenable: userController.userAddress,
                    builder: (context, user, child) {
                      if (!userController.isLoading.value) {
                        if (user != null) {
                          return CardlocationWidget(user: user);
                        } else {
                          return const Center(
                            child: Text(
                              'Nenhum usuário encontrado',
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                          );
                        }
                      }
                      // Retorna um sizedBox vazio com o shrink.
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),

              Container(
                color: const Color.fromARGB(255, 168, 88, 9),
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
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                //Vai para telaIncricao();
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 50),
                      backgroundColor:
                          const Color.fromARGB(255, 146, 146, 146)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaInscricao()));
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
            ],
          ),
        ),
        floatingActionButton: const AlertaEntrar(text: 'Ola'),
      ),
    );
  }
}
