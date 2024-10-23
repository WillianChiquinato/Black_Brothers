import 'package:flutter/material.dart';
import 'package:projetosflutter/API/modelo_user.dart';

class CardlocationWidget extends StatelessWidget {
  const CardlocationWidget({super.key, this.user});
  final UserClass? user;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Usuario: ${user?.id}"),
            Text("Nome: ${user?.nome}"),
            Text("Idade: ${user?.idade}"),
            Text("Plano: ${user?.plano}")
          ],
        ),
      ),
    );
  }
}
