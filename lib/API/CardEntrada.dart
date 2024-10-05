import 'package:flutter/material.dart';
import 'package:projetosflutter/API/modelo_User.dart';

class CardlocationWidget extends StatelessWidget {
  const CardlocationWidget({super.key, this.User});
  final UserClass? User;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Usuario: ${User?.id}"),
            Text("Nome: ${User?.nome}"),
            Text("Idade: ${User?.idade}"),
            Text("Plano: ${User?.plano}")
          ],
        ),
      ),
    );
  }
}
