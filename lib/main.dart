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
      home: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
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
          Stack(
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
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.greenAccent,
                height: 50,
                width: 50,
              ),
              Container(
                color: Colors.pink,
                height: 50,
                width: 50,
              ),
              Container(
                color: Colors.purple,
                height: 50,
                width: 50,
              )
            ],
          ),
        ],
      )

      // Column ou Row(
      //   //Column mainAxisAlignment = Eixo principal de alinhamento da COLUNA, Vertical
      //   //Row mainAxisAlignment = Eixo principal de alinhamento da LINHA, horizontal
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   //Column crossAxisAlignment, manipulando o eixo contrário que corta ele, no caso o eixo X, horizontal
      //   //Row crossAxisAlignment, manipulando o eixo contrário que corta ele, no caso o eixo Y, vertical
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     Container(
      //       color: Colors.orange,
      //       height: 100,
      //       width: 100,
      //     ),
      //     Container(
      //       color: Colors.deepOrangeAccent,
      //       height: 100,
      //       width: 100,          ),
      //   ],
      // ),

      // Stack(
      //   //Alinhamento direcional, alterando esse alinhamento conforma desejado
      //   alignment: AlignmentDirectional.center,
      //   children: [
      //     Container(
      //       color: Colors.orange,
      //     ),
      //     Container(
      //       color: Colors.deepOrangeAccent,
      //       height: 500,
      //       width: 300,          ),
      //   ],
      // ),

      // Container(
      //   color: Colors.orange,
      //   //Criando um filho diretamente com esse container
      //   //Container nao faz sobreposicao, entao nao fica um em cima do outro, ele substitui
      //   child: Container(
      //   color: Colors.redAccent,
    );
  }
}
