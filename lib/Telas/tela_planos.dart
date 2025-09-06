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

  //page controller par a animacao dos cards.
  final PageController _pageController = PageController(viewportFraction: 0.85);

  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);

  final List<Map<String, dynamic>> planos = [
    {
      'id': 1,
      'nome': 'BASIC',
      'imagem': 'Assets/plan_basic.jpg',
      'preco': 'R\$ 69,90/mês',
      'beneficios': '+ 12 Meses Fidelidade + DashBoard + Treinos Opcionais',
    },
    {
      'id': 2,
      'nome': 'PLUS',
      'imagem': 'Assets/plan_plus.jpg',
      'preco': 'R\$ 84,90/mês',
      'beneficios': '+ 12 ausência de fidelidade + dashboard + treinos opcionais + treinos particulares a cada 6 meses',
    },
    {
      'id': 3,
      'nome': 'GOLD',
      'imagem': 'Assets/plan_gold.jpg',
      'preco': 'R\$ 119,90/mês',
      'beneficios': '+ 12 ausência de fidelidade + dashboard + treinos opcionais + treinos particulares a cada 6 meses + consulta com nutricionista a cada 2 meses + acesso a todas as filiais da black brothers',
    }
  ];

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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => TelaInicial()),
            (route) => false,
      );
    } else {
      print('Erro ao criar aluno');
    }
  }

  Widget _buildPlanCard(Map<String, dynamic> plano, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 100.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              plano['nome'],
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(plano['imagem']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              plano['preco'],
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              plano['beneficios'],
              style: TextStyle(fontSize: 18, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _criarAluno(widget.usuarioId, plano['id']);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Assinatura realizada com sucesso!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 4, 220, 0),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Assinar',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: 'Poppins'),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: grey,
        ),
        body: Container(
          color: grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'BLACK BROTHERS',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF8C42),
                          fontFamily: 'Poppins'),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 5),
                    const Text(
                      'Escolha o seu plano de treino',
                      style: TextStyle(fontSize: 18,
                          color: Colors.white70,
                          fontFamily: 'Poppins'
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: planos.length,
                  itemBuilder: (context, index) {
                    final plano = planos[index];
                    return _buildPlanCard(plano, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}