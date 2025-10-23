import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projetosflutter/API/Models/modelo_planos.dart';
import 'package:projetosflutter/API/Models/modelo_tipoPlano.dart';
import 'package:projetosflutter/Telas/tela_inicial.dart';
import '../API/Models/modelo_pessoa.dart';
import '../API/Models/modelo_telefone.dart';
import '../API/Models/modelo_usuario.dart';
import '../API/controller.dart';
import '../Components/ToastMessage.dart';

class TelaPlanos extends StatefulWidget {
  final String dtNascUser;
  final String cpfUser;
  final String nomeUser;
  final String nomeCompletoUser;
  final String senhaUser;
  final String tellUser;
  final String emailUser;

  const TelaPlanos(
      {super.key,
      required this.dtNascUser,
      required this.cpfUser,
      required this.nomeUser,
      required this.nomeCompletoUser,
      required this.senhaUser,
      required this.tellUser,
      required this.emailUser});

  @override
  State<TelaPlanos> createState() => _TelaPlanosState();
}

class _TelaPlanosState extends State<TelaPlanos> {
  late int usuarioId;

  late GenericController<PlanoClass> _planoController;
  late List<PlanoClass> plano = [];

  late GenericController<TipoPlanoClass> _tipoPlanoController;
  late List<TipoPlanoClass> tipoPlano = [];

  late GenericController<PessoaClass> _pessoaController;
  late List<PessoaClass> pessoa = [];

  late GenericController<UsuarioClass> _usuarioController;
  late List<UsuarioClass> usuario = [];

  late GenericController<TelefoneClass> _telefoneController;
  late List<TelefoneClass> telefone = [];

  //page controller par a animacao dos cards.
  final PageController _pageController = PageController(viewportFraction: 0.85);

  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);

  late Future<List<TipoPlanoClass>> planos;

  // final List<Map<String, dynamic>> planos = [
  //   {
  //     'id': 1,
  //     'nome': 'BASIC',
  //     'imagem': 'Assets/basicPlan.png',
  //     'preco': 'R\$ 69,90/mês',
  //     'beneficios': '+ 12 Meses Fidelidade + DashBoard + Treinos Opcionais',
  //   },
  //   {
  //     'id': 2,
  //     'nome': 'PLUS',
  //     'imagem': 'Assets/plusPlan.png',
  //     'preco': 'R\$ 84,90/mês',
  //     'beneficios':
  //         '+ 12 ausência de fidelidade + dashboard + treinos opcionais + treinos particulares a cada 6 meses',
  //   },
  //   {
  //     'id': 3,
  //     'nome': 'GOLD',
  //     'imagem': 'Assets/goldPlan.png',
  //     'preco': 'R\$ 119,90/mês',
  //     'beneficios':
  //         '+ 12 ausência de fidelidade + dashboard + treinos opcionais + treinos particulares a cada 6 meses + consulta com nutricionista a cada 2 meses + acesso a todas as filiais da black brothers',
  //   }
  // ];

  @override
  void initState() {
    super.initState();
    _planoController = GenericController<PlanoClass>(
      endpoint: 'Plano/register',
      fromJson: (json) => PlanoClass.fromJson(json),
    );

    _pessoaController = GenericController(
      endpoint: 'Pessoa/register',
      fromJson: (json) => PessoaClass.fromJson(json),
    );

    _tipoPlanoController = GenericController(
      endpoint: 'Tipo_Plano/register',
      fromJson: (json) => TipoPlanoClass.fromJson(json),
    );

    _usuarioController = GenericController<UsuarioClass>(
      endpoint: 'Usuario/register',
      fromJson: (json) => UsuarioClass.fromJson(json),
    );

    _telefoneController = GenericController<TelefoneClass>(
        endpoint: 'Telefone/register',
        fromJson: (json) => TelefoneClass.fromJson(json));

    planos = carregarPlanos();
  }

  Future<List<TipoPlanoClass>> carregarPlanos() async {
    final planosRegister = await _tipoPlanoController.getAll();
    for (var plano in planosRegister) {
      print(
          'ID: ${plano.id}, Nome: ${plano.nomePlano}, Preço: ${plano.precoPlano}, Benefícios: ${plano.beneficiosPlano}');
    }
    if (planosRegister == null || planosRegister.isEmpty) return [];

    return planosRegister.cast<TipoPlanoClass>();
  }

  //Criar usuário.
  Future<void> _criarPessoa() async {
    String? dataFormatada;
    String cpfLimpo = widget.cpfUser.replaceAll(RegExp(r'[^0-9]'), '');

    try {
      // Converte de dd/MM/yyyy para yyyy-MM-dd
      DateTime data = DateFormat('dd/MM/yyyy').parse(widget.dtNascUser.trim());
      dataFormatada = DateFormat('yyyy-MM-dd').format(data);
    } catch (e) {
      print('Erro ao formatar a data: $e');
      return;
    }

    Map<String, dynamic> data = {
      'CPF': cpfLimpo,
      'Nome': widget.nomeCompletoUser.trim(),
      'Email': widget.emailUser.trim(),
      'DtNasc': dataFormatada,
      'FK_Academia_ID': '12345678000100'
    };

    print('Dados enviados: $data');

    var resultado = await _pessoaController.registerPessoa(data);
    //Resultado Pessoa.
    if (resultado != null) {
      setState(() {
        pessoa = [resultado];
      });

      final pessoaId = resultado.CPF;

      await _criarTelefone(pessoaId);
      await _criarUsuario(pessoaId);

      print('Pessoa criada com sucesso!!');
      showToast(context, "Usuário criado com sucesso!",
          type: ToastType.success);
    } else {
      print('Usuario com esse CPF cadastrado');
    }
  }

  Future<void> _criarTelefone(String pessoaId) async {
    String telefoneLimpo = widget.tellUser.replaceAll(RegExp(r'[^0-9]'), '');

    if (telefoneLimpo.length != 11) {
      print("Telefone inválido, precisa ter 11 dígitos");
      return;
    }

    Map<String, dynamic> dataTell = {
      'Telefone01': telefoneLimpo,
      'Telefone02': telefoneLimpo,
      'FK_CPF': pessoaId,
      'FK_TipoTel_ID': 2,
    };

    print('Telefone enviado: $dataTell');

    var resultadoTell = await _telefoneController.registerTelefone(dataTell);
    //Resultado Telefone.
    if (resultadoTell != null) {
      setState(() {
        telefone = [resultadoTell];
      });

      print('Telefone criado com sucesso!!');
    } else {
      print('Telefone não cadastrado');
    }
  }

  //Apos o cadastro ja pega o login tambem.
  Future<void> _criarUsuario(String pessoaId) async {
    Map<String, dynamic> usuarioData = {
      'Login': widget.nomeUser.trim(),
      'Senha': widget.senhaUser.trim(),
      'FK_Pessoa_ID': pessoaId,
    };

    var resultado = await _usuarioController.registerUsuario(usuarioData);
    if (resultado != null) {
      setState(() {
        usuario = [resultado];
      });
      usuarioId = resultado.id!;

      print('Usuário criado com sucesso!');
    } else {
      print('Erro ao criar usuário');
    }
  }

  Future<void> _criarPlano(int usuarioId, int planoId) async {
    Map<String, dynamic> planoData = {
      'FK_Usuario_ID': usuarioId,
      'FK_TipoPlano_ID': planoId
    };

    var resultado = await _planoController.registerPlano(planoData);
    if (resultado != null) {
      print('Plano criado com sucesso!');

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => TelaInicial()),
          (route) => false,
        );
      });
    } else {
      print('Erro ao criar plano');
    }
  }

  Widget _buildPlanCard(Map<String, dynamic> plano, BuildContext context) {
    final imagemPlano = AssetImage(
      () {
        switch (plano['id']) {
          case 1:
            return 'Assets/basicPlan.png';
          case 2:
            return 'Assets/plusPlan.png';
          case 3:
            return 'Assets/goldPlan.png';
          default:
            return 'Assets/goldPlan.png';
        }
      }(),
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
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
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                plano['nome'],
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: imagemPlano,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'R\$ ${plano['preco'].toStringAsFixed(2)}/Mês',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (plano['beneficios'] as String)
                  .split(';')
                  .where((b) => b.trim().isNotEmpty)
                  .map((b) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: Colors.orangeAccent,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                b.trim(),
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _criarPessoa();
                await _criarPlano(usuarioId, plano['id']);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 4, 220, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: FutureBuilder<List<TipoPlanoClass>>(
                  future: planos,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('Nenhum plano disponível'));
                    }

                    final planosData = snapshot.data!;
                    return PageView.builder(
                      controller: _pageController,
                      itemCount: planosData.length,
                      itemBuilder: (context, index) {
                        final plano = planosData[index];
                        // Se você quer continuar usando _buildPlanCard, transforme o plano em Map:
                        return _buildPlanCard({
                          'id': plano.id,
                          'nome': plano.nomePlano,
                          'imagem': '',
                          'preco': plano.precoPlano,
                          'beneficios': plano.beneficiosPlano,
                        }, context);
                      },
                    );
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
