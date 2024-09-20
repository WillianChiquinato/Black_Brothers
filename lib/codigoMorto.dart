//Column ou Row(
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

//Stack(
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

//Container(
//   color: Colors.orange,
//   //Criando um filho diretamente com esse container
//   //Container nao faz sobreposicao, entao nao fica um em cima do outro, ele substitui
//   child: Container(
//   color: Colors.redAccent,

//FloatingActionButton é um botao flutuante que fica no Footer do aplicativo, sabe o icone de whatsapp que todos os sites tem?, entao esse é um floating.
// floatingActionButton: FloatingActionButton(onPressed: (){}),

//Scaffold é o começo de todos os projetos, o HEAD no html, com essa estrutura, aonde o body é o nosso conteudo.
// Scaffold(
// appBar: AppBar(
// title: Text('Black Brothers'),
// ),
// body:


//StatelessWidget para tarefas repetitivas.
//Voce pode fazer um layout inteiro e so chamar a funcao aonde vc quer, muito util para Containers com muitos detalhes.
//Um widget que vc pode modelar a vontade, com o msm codigo, e depois ficar reutilizando.

//class InputUsuario extends StatelessWidget {
//   //Criando uma variavel para separar cada Container pelo o que eu quero (Especificando cada Container).
//   //Pode ser o que vc quiser, String, int qualquer variavel.
//   //Nesse caso usei Color para mudar a cor de fundo, ai so referenciar a variavel aonde quer e completar o parametro na chamada da funcao.
//   final Color nomeCaminho;
//   const InputUsuario(this.nomeCaminho, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     //Após o return colocar o widget que quer
//     return Stack(alignment: AlignmentDirectional.center, children: [
//       Container(
//         color: nomeCaminho,
//         height: 50,
//         width: 300,
//       ),
//     ]);
//   }
// }

//Visualização em lista, ScrollBar da tela.
//Default como vertical.
//Widget: ListView(
//   ScrollDirection: Axis.horizontal ou vertical,
//    childen: [
//      bla bla;
//    ]
// ),

//Padding, dando Alt+Enter aonde vc quer o padding, vai vim com essa estrutura.
// Padding(
//    padding: const EdgeInsets.only(bottom: 40.0),
// child: Stack ou Container, o body aqui.

//Sobre text, quando o texto é muito grande e nao cabe no container, ele colocar ... no final
//Overflow: TextOverFlow.elipsis,