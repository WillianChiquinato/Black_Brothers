import 'package:flutter/material.dart';
import 'package:projetosflutter/API/models/modelo_aluno.dart';
import 'package:projetosflutter/Telas/tela_inicial.dart';

import '../API/controller.dart';

class TelaPlanos extends StatefulWidget {
  final int usuarioId;

  const TelaPlanos({super.key, required this.usuarioId});

  @override
  State<TelaPlanos> createState() => _TelaPlanosState();
}

class _TelaPlanosState extends State<TelaPlanos> {
  late GenericController<AlunoClass> _alunoController;
  late List<AlunoClass> aluno = [];

  @override
  void initState() {
    super.initState();

    _alunoController = GenericController<AlunoClass>(
      endpoint: 'Aluno',
      fromJson: (json) => AlunoClass.fromJson(json),
    );
  }

  Future<void> _criarAluno(int usuarioId, int planoId) async {
    Map<String, dynamic> alunoData = {
      'FK_Usuario_ID': usuarioId,
      'FK_Planos_ID': planoId
    };

    var resultado = await _alunoController.create(alunoData);
    if (resultado != null) {
      print('Aluno criado com sucesso!');
      // Voltar para login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => TelaInicial()),
            (route) => false,
      );
    } else {
      print('Erro ao criar aluno');
    }
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: 'BlackBrothers'),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: const Color.fromARGB(255, 210, 125, 43),
        ),
        body: Container(
          color: const Color.fromARGB(255, 210, 125, 43),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Antes de concluir o cadastro, escolha um plano',
                  style: TextStyle(fontSize: 23, color: Colors.white),
                ),
                Container(
                  height: 600,
                  width: 600,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white, width: 4.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'BASIC',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('Assets/plan_basic.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'R\$ 69,90/mês',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '+ 12 Meses Fidelidade + DashBoard + Treinos Opcionais',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await _criarAluno(widget.usuarioId, 1);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Assinatura realizada com sucesso!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TelaInicial()),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 4, 220, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Assinar',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'PLUS',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('Assets/plan_plus.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'R\$ 84,90/mês',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '+ 12 ausência de fidelidade + dashboard + treinos opcionais + treinos particulares a cada 6 meses ',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await _criarAluno(widget.usuarioId, 2);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Assinatura realizada com sucesso!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TelaInicial()),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 4, 220, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Assinar',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'GOLD',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                  image: AssetImage('Assets/plan_gold.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'R\$ 119,90/mês',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '+ 12 ausência de fidelidade + dashboard + treinos opcionais + treinos particulares a cada 6 meses + consulta com nutricionista a cada 2 meses + acesso a todas as filiais da black brothers ',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white70),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await _criarAluno(widget.usuarioId, 3);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Assinatura realizada com sucesso!'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TelaInicial()),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 4, 220, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Assinar',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
