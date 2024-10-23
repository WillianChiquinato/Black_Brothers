import 'package:flutter/material.dart';

class AlertaEntrar extends StatefulWidget {
  final String text;

  const AlertaEntrar({super.key, required this.text});

  @override
  State<AlertaEntrar> createState() => _AlertaEntrarState();
}

class _AlertaEntrarState extends State<AlertaEntrar> {
  void _showPopup(BuildContext context, String nomePlaceholder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Bem-vindo!"),
          content: const Text(
              "Aqui esta um text para dizer que o CONTEXT é o conteudo do alerta"),
          actions: <Widget>[
            TextButton(
              child: const Text("Fechar"),
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
        _showPopup(context, widget.text);
      },
      child: const Icon(Icons.add_card_rounded),
    );
  }
}