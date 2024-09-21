import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //Home é o nosso BODY no Flutter.
      //Stack, empilhar uma em cima da outra.,
      //Um em cima do outro com stack, literalmente em forma de pilha
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 168, 88, 9),
        ),
        body: Container(
          //Filtrando a cor com o RGB, modelando com o fromARGB, mas nao da pra pegar a cor, tem que pegar externa
          color: Color.fromARGB(255, 168, 88, 9),
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
                  child: Image.asset('Assets/Black_Brother.png', fit: BoxFit.cover),
                ),
              ),
              InputUsuario('Usuario'),
              InputUsuario('Senha'),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50),
                      backgroundColor: Color.fromARGB(255, 77, 37, 0),),
                  onPressed: () {
                    print('Pressionou');
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                color: Color.fromARGB(255, 168, 88, 9),
                height: 50,
                width: 2000,
                child: const Text(
                  '---------------- OU ----------------',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              //Para o botao e o Text para adicinar texto e TEXSTYLE para estilizaçao
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50),
                      backgroundColor: Color.fromARGB(255, 146, 146, 146)),
                  onPressed: () {
                    print('Pressionou');
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
        floatingActionButton: AlertaEntrar(text: 'Ola'),
      ),
    );
  }
}

//StatelessWidget para tarefas repetitivas.
//Estatico, sem mudanca de valores, sem atualizar na tela
class InputUsuario extends StatefulWidget {
  final String nomePlaceholder;

  const InputUsuario(this.nomePlaceholder, {super.key});

  @override
  State<InputUsuario> createState() => _InputUsuarioState();
}

class _InputUsuarioState extends State<InputUsuario> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 35.0, left: 25.0, right: 25.0),
        child: Container(
          width: 330,
          height: 60,
          child: TextField(
            decoration: InputDecoration(
              hintText: widget.nomePlaceholder,
              filled: true,
              fillColor: Colors.white70,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
        ));
  }
}

class AlertaEntrar extends StatelessWidget {
  final String text;

  AlertaEntrar({required this.text});

  void _showPopup(BuildContext context, String nomePlaceholder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Bem-vindo!"),
          content: Text(
              "Aqui esta um text para dizer que o CONTEXT é o conteudo do alerta"),
          actions: <Widget>[
            TextButton(
              child: Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o popup
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showPopup(context, '$text');
      },
      child: Icon(Icons.add_card_rounded),
    );
  }
}
