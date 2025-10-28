import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/Models/modelo_aluno.dart';
import 'package:projetosflutter/API/Models/modelo_exercicio.dart';
import 'package:projetosflutter/API/Models/modelo_instrutor.dart';
import 'package:projetosflutter/API/Models/modelo_treinoExercicio.dart';
import 'package:projetosflutter/API/models/modelo_tipoPlano.dart';
import 'package:projetosflutter/API/Models/modelo_treino.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';
import 'package:projetosflutter/API/controller.dart';
import 'package:projetosflutter/Components/ToastMessage.dart';

class MenuTreino extends StatefulWidget {
  final UsuarioClass? user;
  final TipoPlanoClass? plan;

  const MenuTreino({super.key, this.user, this.plan});

  @override
  State<MenuTreino> createState() => _MenuTreinoState();
}

class _MenuTreinoState extends State<MenuTreino> {
  late GenericController<TreinoExercicioClass> _treinoExercicioController;
  late GenericController<TreinoClass> _treinoController;
  late GenericController<AlunoClass> _alunoController;
  late GenericController<ExercicioClass> _exercicioController;
  late GenericController<InstrutorClass> _instrutorController;

  late List<ExercicioClass> exercicios = [];
  late List<TreinoExercicioClass> treinoExercicios = [];
  InstrutorClass? instrutor;

  @override
  void initState() {
    super.initState();

    _treinoExercicioController = GenericController(
      endpoint: 'treino_exercicio',
      fromJson: (json) => TreinoExercicioClass.fromJson(json),
    );

    _treinoController = GenericController(
      endpoint: 'Treino',
      fromJson: (json) => TreinoClass.fromJson(json),
    );

    _alunoController = GenericController(
      endpoint: 'Aluno',
      fromJson: (json) => AlunoClass.fromJson(json),
    );

    _exercicioController = GenericController(
      endpoint: 'Exercicio',
      fromJson: (json) => ExercicioClass.fromJson(json),
    );

    _instrutorController = GenericController(
      endpoint: 'Empregado',
      fromJson: (json) => InstrutorClass.fromJson(json),
    );

    carregarTreinos();
  }

  Future<void> carregarTreinos() async {
    final treinos = await carregarTreinosDoAlunoEInstrutor(widget.user?.id);
    print('Treinos carregados: ${treinos.length}');
  }

  // Carrega treinos do aluno
  Future<List<TreinoClass>> carregarTreinosDoAlunoEInstrutor(int? usuarioId) async {
    if (usuarioId == null) return [];

    final aluno = await _getAlunoPorUsuarioId(usuarioId);
    if (aluno == null) return [];

    final treinos = await _getTreinosDoAluno(aluno.Matricula);
    if (treinos.isEmpty) return [];

    instrutor = (await _getIntrutorDosTreinos(aluno.Matricula)) as InstrutorClass;
    print('CUZIN: ' + instrutor.toString());
    await _carregarExerciciosDosTreinos(treinos);

    return treinos;
  }

  //Busca instrutor.
  Future<List<InstrutorClass>> _getIntrutorDosTreinos(int alunoId) async {
    final treinos = await _treinoController.getAll();

    if (treinos == null || treinos.isEmpty) return [];

    final treinosDoAluno = treinos.where((t) => t.FK_Aluno_ID == alunoId).toList();
    if (treinosDoAluno.isEmpty) return [];

    final instrutoresIds = treinosDoAluno.map((t) => t.FK_Instrutor_ID).toSet().toList();
    final instrutores = await _instrutorController.getByQuery('ID IN (${instrutoresIds.join(',')})');

    return instrutores ?? [];
  }

  // Busca aluno pelo usuário
  Future<AlunoClass?> _getAlunoPorUsuarioId(int usuarioId) async {
    final alunos =
        await _alunoController.getByQuery('FK_Usuario_ID=$usuarioId');
    if (alunos == null || alunos.isEmpty) return null;
    return alunos.first;
  }

  // Busca treinos do aluno
  Future<List<TreinoClass>> _getTreinosDoAluno(int alunoId) async {
    final todosTreinos = await _treinoController.getAll();
    if (todosTreinos == null || todosTreinos.isEmpty) return [];
    return todosTreinos.where((t) => t.FK_Aluno_ID == alunoId).toList();
  }

  // Carrega todos os exercícios relacionados aos treinos
  Future<void> _carregarExerciciosDosTreinos(List<TreinoClass> treinos) async {
    final treinoIds = treinos.map((t) => t.id).toList();
    if (treinoIds.isEmpty) return;

    final treinoExercicioRelacionado = await _treinoExercicioController
        .getByQuery('FK_Treino_ID IN (${treinoIds.join(',')})');

    treinoExercicios = treinoExercicioRelacionado ?? [];

    final exercicioIds =
        treinoExercicioRelacionado?.map((te) => te.FK_Exercicio_ID).toList() ??
            [];

    if (exercicioIds.isNotEmpty) {
      exercicios = await _exercicioController
          .getByQuery('ID IN (${exercicioIds.join(',')})');
    }
  }

  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildInfoUsuario(),
          _buildDiasSemana(),
          Expanded(
            child: FutureBuilder<List<TreinoClass>>(
              future: carregarTreinosDoAlunoEInstrutor(widget.user?.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar treinos.",
                        style: GoogleFonts.poppins(color: Colors.red)),
                  );
                }

                final treinos = snapshot.data ?? [];
                if (treinos.isEmpty) {
                  return Center(
                    child: Text("Nenhum treino disponível.",
                        style:
                            GoogleFonts.poppins(color: grey.withOpacity(0.6))),
                  );
                }

                return _buildGridTreinos(context, treinos);
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: grey,
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
    );
  }

  Widget _buildInfoUsuario() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.plan?.nomePlano}',
                  style: GoogleFonts.poppins(
                      color: orange, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('${widget.user?.login}',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 18),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: lightOrange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.fitness_center, size: 16, color: orange),
                    const SizedBox(width: 4),
                    Text("Treino: ${instrutor?.descricao}",
                        style: GoogleFonts.poppins(fontSize: 12, color: grey)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDiasSemana() {
    final List<Map<String, String>> datasMock = [
      {"dia": "SEX", "data": "12", "ativo": "false"},
      {"dia": "SÁB", "data": "13", "ativo": "false"},
      {"dia": "DOM", "data": "14", "ativo": "false"},
      {"dia": "SEG", "data": "15", "ativo": "false"},
      {"dia": "TER", "data": "16", "ativo": "false"},
      {"dia": "QUA", "data": "17", "ativo": "true"},
      {"dia": "QUI", "data": "18", "ativo": "false"},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: datasMock.length,
        itemBuilder: (context, index) {
          final item = datasMock[index];
          final bool isToday = item['ativo'] == 'true';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['dia']!,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: grey.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isToday ? orange : lightOrange,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isToday ? orange : grey.withOpacity(0.2),
                      width: isToday ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    item['data']!,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isToday ? Colors.white : grey,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridTreinos(BuildContext context, List<TreinoClass> treinos) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: treinos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final treino = treinos[index];

          return InkWell(
            onTap: () {
              final exerciciosDoTreino = treinoExercicios
                  .where((te) => te.FK_Treino_ID == treino.id)
                  .map((te) => exercicios
                      .firstWhere((ex) => ex.id == te.FK_Exercicio_ID))
                  .toList();

              // Mostra detalhes do treino
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (BuildContext context) {
                  return _TreinoDetalheSheet(
                    titulo: treino.nome ?? '',
                    exerciciosTreino: exerciciosDoTreino,
                  );
                },
              );
            },
            child: Card(
              elevation: 6,
              color: lightOrange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.fitness_center, size: 40, color: orange),
                    const SizedBox(height: 8),
                    Text(
                      treino.nome ?? 'Treino',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      treino.nome ?? '',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: grey.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TreinoDetalheSheet extends StatefulWidget {
  final String titulo;
  final List<ExercicioClass> exerciciosTreino;
  const _TreinoDetalheSheet(
      {required this.titulo, required this.exerciciosTreino});

  @override
  State<_TreinoDetalheSheet> createState() => _TreinoDetalheSheetState();
}

class _TreinoDetalheSheetState extends State<_TreinoDetalheSheet> {
  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);
  final Color red = Colors.red;
  final Color green = Colors.green;

  bool treinoIniciado = false;
  int segundos = 0;
  Timer? timer;

  // permite finalizar apenas se o treino comecou e todos os exercicios foram concluidos
  bool get podeFinalizar =>
      treinoIniciado &&
      widget.exerciciosTreino.every((ex) => ex.concluido == true);

  String formatarTempo(int segundosTotais) {
    final horas = (segundosTotais ~/ 3600).toString().padLeft(2, '0');
    final minutos = ((segundosTotais % 3600) ~/ 60).toString().padLeft(2, '0');
    final segundos = (segundosTotais % 60).toString().padLeft(2, '0');
    return "$horas:$minutos:$segundos";
  }

  // cronometro
  void iniciarCronometro() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => segundos++);
    });
  }

  void pararCronometro() {
    timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(widget.titulo,
              style: GoogleFonts.poppins(
                  fontSize: 22, fontWeight: FontWeight.bold, color: grey)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: orange, width: 2),
            ),
            child: Text(
              formatarTempo(segundos),
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: orange,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                label: Text("Iniciar Treino",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                onPressed: treinoIniciado
                    ? null
                    : () {
                        setState(() {
                          treinoIniciado = true;
                          segundos = 0;
                        });
                        iniciarCronometro();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: treinoIniciado ? Colors.grey : green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.flag, color: Colors.white),
                label: Text("Finalizar Treino",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                onPressed: podeFinalizar
                    ? () {
                        pararCronometro();
                        final duracao = formatarTempo(segundos);
                        showToast(
                            context, "Treino concluido em ${duracao} segundos",
                            type: ToastType.success);
                        Navigator.pop(context);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: podeFinalizar ? red : Colors.grey.shade400,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.exerciciosTreino.length,
              itemBuilder: (context, index) {
                final ex = widget.exerciciosTreino[index];
                final bool isConcluido = ex.concluido;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: isConcluido ? 6 : 2,
                  color:
                      isConcluido ? lightOrange.withOpacity(0.8) : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isConcluido ? green : grey.withOpacity(0.2),
                      width: isConcluido ? 2 : 1,
                    ),
                  ),
                  child: ExpansionTile(
                    iconColor: isConcluido ? green : orange,
                    collapsedIconColor: grey.withOpacity(0.7),
                    tilePadding: const EdgeInsets.only(right: 18),
                    initiallyExpanded: ex.expandido,
                    title: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Checkbox(
                            value: ex.concluido,
                            onChanged: treinoIniciado
                                ? (value) {
                                    setState(() {
                                      ex.concluido = value!;
                                    });
                                  }
                                : null,
                            activeColor: green,
                            checkColor: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${ex.nome}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              decoration: isConcluido
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: isConcluido ? grey.withOpacity(0.6) : grey,
                            ),
                          ),
                        ),
                        if (isConcluido)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.check_circle,
                                color: green, size: 20),
                          ),
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(ex.thumbnail, height: 150),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.play_circle,
                                  color: Colors.white),
                              label: Text("Ver vídeo de demonstração",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
