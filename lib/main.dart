import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //Home é o nosso BODY no Flutter.
      //Stack, empilhar uma em cima da outra.
      //Um em cima do outro com stack, literalmente em forma de pilha
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 174, 134, 57),
        ),
        body: Container(
          //Filtrando a cor com o RGB, modelando com o fromARGB, mas nao da pra pegar a cor, tem que pegar externa
          color: Color.fromARGB(255, 174, 134, 57),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Vai ser da imagem
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      color: Colors.orange,
                      height: 100,
                      width: 100,
                    ),
                    Container(
                      color: Colors.redAccent,
                      height: 50,
                      width: 50,
                    )
                  ],
                ),
              ),
              InputUsuario(Colors.black),
              InputUsuario(Colors.orangeAccent),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 50),
                      backgroundColor: Colors.white10),
                  onPressed: () {
                    print('Pressionou');
                  },
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                color: Color.fromARGB(255, 174, 134, 57),
                height: 50,
                width: 2000,
                child: Text(
                  '---------------- OU ----------------',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              //Para o botao e o Text para adicinar texto e TEXSTYLE para estilizaçao
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 50),
                    backgroundColor: Colors.white54),
                onPressed: () {
                  print('Pressionou');
                },
                child: Text(
                  'Inscrever-se',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add_card_rounded),
        ),
      ),
    );
  }
}

//StatelessWidget para tarefas repetitivas.
//Voce pode fazer um layout inteiro e so chamar a funcao aonde vc quer, muito util para Containers com muitos detalhes.
//Um widget que vc pode modelar a vontade, com o msm codigo, e depois ficar reutilizando.
class InputUsuario extends StatelessWidget {
  //Criando uma variavel para separar cada Container pelo o que eu quero (Especificando cada Container).
  //Pode ser o que vc quiser, String, int qualquer variavel.
  //Nesse caso usei Color para mudar a cor de fundo, ai so referenciar a variavel aonde quer e completar o parametro na chamada da funcao.
  final Color nomeCaminho;
  const InputUsuario(this.nomeCaminho, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Stack(alignment: AlignmentDirectional.center, children: [
        Container(
          color: nomeCaminho,
          height: 50,
          width: 300,
        ),
      ]),
    );
  }
}
