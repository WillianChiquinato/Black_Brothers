import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:projetosflutter/API/models/modelo_aluno.dart';
import 'package:projetosflutter/API/models/modelo_telefone.dart';
import 'package:projetosflutter/API/models/modelo_tipoPlano.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';

import '../API/controller.dart';
import '../API/models/modelo_pessoa.dart';
import '../Util/FormatItens.dart';

class MenuPerfil extends StatefulWidget {
  final UsuarioClass? user;
  final TipoPlanoClass? plan;

  const MenuPerfil({super.key, this.user, this.plan});

  @override
  State<MenuPerfil> createState() => _MenuPerfilState();
}

class _MenuPerfilState extends State<MenuPerfil> with TickerProviderStateMixin {
  final dtnascController = TextEditingController();
  final tellController = TextEditingController();
  final cpfController = TextEditingController();

  late GenericController<PessoaClass> _pessoaController;
  late GenericController<TelefoneClass> _telefoneController;
  late GenericController<AlunoClass> _alunoController;
  late TelefoneClass? telefonePessoa;

  late UsuarioClass? usuario;
  late TipoPlanoClass? plano;
  late AlunoClass? aluno;
  late TabController _tabController;

  String? usuarioNome;
  String? usuarioDtNasc;
  String? usuarioCpf;
  String? usuarioTell;
  String? usuarioEmail;

  double? altura;
  double? peso;

  final lightOrange = const Color(0xFFFFF1E6);
  final orange = const Color(0xFFFF8C42);
  final grey = const Color(0xFF333333);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    usuario = widget.user;
    plano = widget.plan;
    super.initState();

    _pessoaController = GenericController(
      endpoint: 'Pessoa',
      fromJson: (json) => PessoaClass.fromJson(json),
    );

    _telefoneController = GenericController(
      endpoint: 'Telefone',
      fromJson: (json) => TelefoneClass.fromJson(json),
    );

    _alunoController = GenericController(
      endpoint: 'Aluno',
      fromJson: (json) => AlunoClass.fromJson(json),
    );

    carregarPessoa();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> carregarPessoa() async {
    final pessoa = await _pessoaController.getOne(usuario!.fK_Pessoa_ID);
    var apiAluUserId = usuario!.id;
    final alunos =
        await _alunoController.getByQuery('FK_Usuario_ID=$apiAluUserId');

    final todosTelefones = await _telefoneController.getAll();
    telefonePessoa =
        todosTelefones.firstWhere((tel) => tel.FK_CPF == pessoa?.CPF);

    setState(() {
      usuarioCpf = pessoa?.CPF;
      usuarioNome = pessoa?.Nome;
      usuarioEmail = pessoa?.Email;
      usuarioTell = telefonePessoa?.Telefone;

      if (alunos.isNotEmpty) {
        aluno = alunos.first;
        altura = aluno!.Altura;
        peso = aluno!.Peso;
      } else {
        aluno = null;
        altura = null;
        peso = null;
      }

      if (pessoa?.DtNasc != null) {
        DateTime parsedDate = FormatUtil.parseRfc1123(pessoa!.DtNasc);
        usuarioDtNasc = DateFormat('dd/MM/yyyy').format(parsedDate);
        dtnascController.text = usuarioDtNasc!;
      }
    });

    //Formatação data de nascimento.
    dtnascController.text =
        usuarioDtNasc != null ? FormatUtil.formatDateInput(usuarioDtNasc!) : '';

    dtnascController.addListener(() {
      final textDataNasc = dtnascController.text;
      final formatted = FormatUtil.formatDateInput(textDataNasc);

      if (formatted != textDataNasc) {
        dtnascController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    });

    //Formatação telefone.
    tellController.text =
        usuarioTell != null ? FormatUtil.formatTellInput(usuarioTell!) : '';

    tellController.addListener(() {
      final textTell = tellController.text;
      final formatted = FormatUtil.formatTellInput(textTell);

      if (formatted != textTell) {
        tellController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    });

    //Formatação CPF.
    cpfController.text =
        usuarioCpf != null ? FormatUtil.formatCpfInput(usuarioCpf!) : '';

    cpfController.addListener(() {
      final texCpf = cpfController.text;
      final formatted = FormatUtil.formatCpfInput(texCpf);

      if (formatted != texCpf) {
        cpfController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    });
  }

  //Update do perfil.
  Future<void> _updatePessoa(
      String newName,
      String newDate,
      String newCpf,
      String newEmail,
      String newTell,
      double newHeight,
      double newWeight) async {
    // Verifica se houve alteração
    if (newName == usuarioNome &&
        newTell == usuarioTell &&
        newDate == usuarioDtNasc &&
        newCpf == usuarioCpf &&
        newEmail == usuarioEmail &&
        newHeight == (altura ?? 0.0) &&
        newWeight == (peso ?? 0.0)) {
      print("Nada alterado, show message futuramente!");
      return;
    }

    var academiaCNPJFixo = "12345678000100";
    String telefoneLimpo = newTell.replaceAll(RegExp(r'[^0-9]'), '');

    try {
      Map<String, dynamic> novosDados = {
        'CPF': newCpf,
        'Nome': newName,
        'Email': newEmail,
        'DtNasc': newDate,
        'FK_Academia_ID': academiaCNPJFixo
      };

      Map<String, dynamic> novosDadosTell = {
        'Telefone01': telefoneLimpo,
        'Telefone02': telefoneLimpo,
        'FK_CPF': newCpf,
        'FK_TipoTel_ID': 2,
      };

      Map<String, dynamic> novoDadosAluno = {
        'altura': newHeight,
        'peso': newWeight,
      };

      var resultado = await _pessoaController.update(usuarioCpf!, novosDados);

      if (telefoneLimpo.length != 11) {
        print("Telefone inválido, precisa ter 11 dígitos");
        return;
      }
      var resultadoTell = await _telefoneController.update(
          telefonePessoa!.id.toString(), novosDadosTell);

      final takeMatricula =
          await _alunoController.getByQuery('FK_Usuario_ID=${usuario!.id}');
      if (takeMatricula.isEmpty) {
        print('Nenhum aluno encontrado para este usuário');
        return;
      }

      final alunoEncontrado = takeMatricula.first;
      var resultadoAluno = await _alunoController.update(
        alunoEncontrado.Matricula.toString(),
        novoDadosAluno,
      );

      //Para Pessoa.
      if (resultado != null) {
        setState(() {
          usuarioCpf = resultado.CPF;
          usuarioNome = resultado.Nome;
          usuarioEmail = resultado.Email;
          usuarioDtNasc = resultado.DtNasc;
        });
        print("Pessoa atualizada");
      } else {
        print("Erro ao atualizar pessoa");
      }

      //Para telefone.
      if (resultado != null) {
        setState(() {
          usuarioTell = resultadoTell?.Telefone;
        });
        print("Telefone atualizado");
      } else {
        print("Erro ao atualizar telefone");
      }

      //Para Aluno.
      if (resultado != null) {
        setState(() {
          altura = resultadoAluno?.Altura;
          peso = resultadoAluno?.Peso;
        });
      }
    } catch (e) {
      print("Erro ao atualizar pessoa: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: grey,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('Assets/iam.jpg'),
              radius: 25,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${plano?.nomePlano}',
                  style: GoogleFonts.poppins(
                    color: orange,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${usuario?.login}',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: orange,
          labelColor: orange,
          unselectedLabelColor: Colors.white,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'DASHBOARD'),
            Tab(text: 'MEU PERFIL'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildPerfilTab(),
        ],
      ),
    );
  }

  Widget _buildPerfilTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Informações Pessoais"),
            const SizedBox(height: 12),
            _buildTextField("Nome", usuarioNome ?? "", onChanged: (value) {
              usuarioNome = value;
            }),
            _buildTextField("Data de Nascimento", usuarioDtNasc ?? "",
                controller: dtnascController, onChanged: (value) {
              usuarioDtNasc = value;
            }),
            _buildTextField(
              "CPF (Apenas Visualização)",
              usuarioCpf ?? "",
              controller: cpfController,
              onChanged: (value) {
                usuarioCpf = value;
              },
              readOnly: true,
            ),
            _buildTextField("Telefone", usuarioTell ?? "",
                controller: tellController, onChanged: (value) {
              usuarioTell = value;
            }),
            _buildTextField("Email", usuarioEmail ?? "", onChanged: (value) {
              usuarioEmail = value;
            }),
            const SizedBox(height: 24),
            _buildSectionTitle("Informações Físicas"),
            const SizedBox(height: 12),
            _buildTextField("Altura", altura?.toString() ?? '',
                onChanged: (value) {
              altura = double.tryParse(value);
            }),
            _buildTextField("Peso", peso?.toString() ?? '', onChanged: (value) {
              peso = double.tryParse(value);
            }),
            const SizedBox(height: 28),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  DateTime parsedDate;
                  print(usuarioDtNasc);
                  final regexNormal = RegExp(r'^\d{2}/\d{2}/\d{4}$');

                  try {
                    if (regexNormal.hasMatch(usuarioDtNasc!)) {
                      // Se for dd/MM/yyyy
                      parsedDate =
                          DateFormat('dd/MM/yyyy').parse(usuarioDtNasc!);
                    } else {
                      // Caso contrário, tenta parsear como RFC 1123
                      parsedDate = FormatUtil.parseRfc1123(usuarioDtNasc!);
                    }

                    String apiDate =
                        DateFormat('yyyy-MM-dd').format(parsedDate);

                    await _updatePessoa(
                        usuarioNome!,
                        apiDate,
                        usuarioCpf!,
                        usuarioEmail!,
                        usuarioTell!,
                        altura ?? 0.0,
                        peso ?? 0.0);
                  } catch (e) {
                    print('Erro ao converter a data: $e');
                    // Aqui você pode tratar o erro ou mostrar mensagem para o usuário
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                ),
                child: Text(
                  "SALVAR ALTERAÇÕES",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: orange, width: 8),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.fitness_center,
                          size: 36, color: Colors.black),
                      Text("100%",
                          style: GoogleFonts.poppins(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("Média", style: GoogleFonts.poppins(color: grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDashboardIcon(Icons.calendar_month, "100%"),
                  _buildDashboardIcon(Icons.message_outlined, "100%"),
                  _buildDashboardIcon(Icons.bar_chart, "100%"),
                  _buildDashboardIcon(Icons.accessibility_new, "100%"),
                ],
              ),
              const SizedBox(height: 24),
              _buildStatusCard(
                  "Peso:",
                  "MÉDIO",
                  "Precisa alinhar sua dieta para ter um aumento de peso",
                  orange),
              const SizedBox(height: 16),
              _buildStatusCard(
                  "Gordura Corporal:",
                  "ELEVADO",
                  "Se alimente e treine melhor para mudar esse quadro",
                  Colors.redAccent),
              const SizedBox(height: 24),
              _buildCorpoResumo(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardIcon(IconData icon, String value) {
    return Column(
      children: [
        Icon(icon, size: 32, color: grey),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }

  Widget _buildStatusCard(
      String titulo, String nivel, String mensagem, Color cor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightOrange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 60,
            color: cor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text(nivel,
                    style: GoogleFonts.poppins(
                        color: cor, fontWeight: FontWeight.bold)),
                Text(mensagem, style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorpoResumo() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("${'1.80'}m",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text("Altura", style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Text("${'60.6'} Kg",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text("Peso", style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Text("${'48'} Kg",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text("Massa Magra", style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Text("${'37'}%",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text("Gordura", style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String? initialValue, {
    TextEditingController? controller,
    void Function(String)? onChanged,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        initialValue: controller == null ? initialValue : null,
        onChanged: onChanged,
        readOnly: readOnly,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(),
          filled: true,
          fillColor: lightOrange,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: grey,
      ),
    );
  }
}
