import 'package:flutter/material.dart';

class MenuInicial extends StatefulWidget {
  const MenuInicial ({super.key});

  @override
  _MenuInicialState createState() => _MenuInicialState();
}

class _MenuInicialState extends State<MenuInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Inicial'),
      ),
      body: Center(
        child: Text('Bem-vindo ao menu inicial!'),
      ),
    );
  }
}