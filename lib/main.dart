import 'package:flutter/material.dart';
import 'package:projetosflutter/Data/Inherite_Login.dart';
import 'Telas/tela_inicial.dart';

void main() {
  runApp(const MainClass());
}

class MainClass extends StatefulWidget {
  const MainClass({super.key});

  @override
  State<MainClass> createState() => _MyAppState();
}

class _MyAppState extends State<MainClass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'BlackBrothers',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginInherite(child: const TelaInicial()),
    );
  }
}
