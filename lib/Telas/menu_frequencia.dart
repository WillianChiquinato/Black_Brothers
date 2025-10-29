import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/Models/modelo_frequencia.dart';
import 'package:projetosflutter/API/controller.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';
import 'package:projetosflutter/API/Models/modelo_aluno.dart';
import '../Util/FormatItens.dart';

class MenuFrequencia extends StatefulWidget {
  final UsuarioClass? user;

  const MenuFrequencia({super.key, this.user});

  @override
  State<MenuFrequencia> createState() => _MenuFrequenciaState();
}

class _MenuFrequenciaState extends State<MenuFrequencia> {
  late GenericController<AlunoClass> _alunoController;
  late GenericController<FrequenciaClass> _frequenciaController;

  List<FrequenciaClass> frequenciaList = [];
  bool isLoading = true;
  int treinoTimer = 0;
  late AlunoClass? alunoRegister;

  @override
  void initState() {
    super.initState();

    _frequenciaController = GenericController(
      endpoint: 'frequencia',
      fromJson: (json) => FrequenciaClass.fromJson(json),
    );

    _alunoController = GenericController(
      endpoint: 'Aluno',
      fromJson: (json) => AlunoClass.fromJson(json),
    );

    carregarFrequencia();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() {
      isLoading = true;
    });

    await carregarFrequencia();
  }

  Future<void> carregarFrequencia() async {
    await carregarAluno();

    if (alunoRegister != null) {
      frequenciaList = await _frequenciaController
          .getByQuery("FK_Aluno_ID=${alunoRegister!.Matricula}");
      print('Frequência carregada: ${frequenciaList.length} itens');
    } else {
      print('Aluno não encontrado');
      frequenciaList = [];
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> carregarAluno() async {
    var alunos =
        await _alunoController.getByQuery("FK_Usuario_ID=${widget.user?.id}");
    if (alunos.isNotEmpty) {
      alunoRegister = alunos.first;
    }
  }

  IconData _getIcon(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'aquecimento':
        return LucideIcons.thermometerSun;
      case 'cardio':
        return LucideIcons.heartPulse;
      default:
        return LucideIcons.dumbbell;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color lightOrange = const Color(0xFFFFF1E6);
    final Color orange = const Color(0xFFFF8C42);
    final Color grey = const Color(0xFF333333);
    IconData _getIcon(String tipo) {
      switch (tipo.toLowerCase()) {
        case 'aquecimento':
          return LucideIcons.thermometerSun;
        case 'cardio':
          return LucideIcons.heartPulse;
        default:
          return LucideIcons.dumbbell;
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: grey,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('Assets/logo-bb.png', height: 40, width: 40),
            const SizedBox(width: 8),
            Text(
              "Black Brothers",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.grey[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: grey),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Text(
                    'Opções',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text('Nutricionista', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: Text('Consultar Dieta', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center),
              title: Text('Treinos', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text('Configurações', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text('Sair', style: GoogleFonts.poppins()),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Suas Frequências",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Confira seus treinos realizados recentemente",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),

              // Corpo principal
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : frequenciaList.isEmpty
                        ? Center(
                            child: Text(
                              'Nenhuma frequência registrada ainda',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: frequenciaList.length,
                            itemBuilder: (context, index) {
                              final f = frequenciaList[index];
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOut,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.orange.withOpacity(0.4),
                                      Colors.orange.withOpacity(0.8),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 1,
                                      offset: const Offset(0, 0.5),
                                    )
                                  ],
                                ),
                                child: ListTile(
                                  leading: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Data do treino
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: Colors.orange
                                                  .withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              FormatUtil.formatDateShort(
                                                  f.dataCriacao ?? ''),
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),

                                      Container(
                                        height: 48,
                                        width: 48,
                                        decoration: BoxDecoration(
                                          color: Colors.orangeAccent
                                              .withOpacity(0.8),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          _getIcon(f.nome ?? ''),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: Text(
                                    f.nome ?? 'Frequência',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Duração: ${FormatUtil.formatDuration(f.duracao)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  // trailing: Icon(
                                  //   LucideIcons.chevronRight,
                                  //   color: Colors.black,
                                  // ),
                                ),
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
