import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              "Whatsapp redirecionamento será aqui"),
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
      backgroundColor: const Color(0xFF25D366),
      onPressed: () {
        _showPopup(context, widget.text);
      },
      child: const FaIcon(FontAwesomeIcons.whatsapp),
    );
  }
}