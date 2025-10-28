import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/models/modelo_planos.dart';
import 'package:projetosflutter/API/models/modelo_tipoPlano.dart';
import '../API/models/modelo_usuario.dart';

class Exercicio {
  final String nome;
  final String series;
  final String imagem;
  final bool temVideo;
  bool concluido;
  bool expandido;

  Exercicio({
    required this.nome,
    required this.series,
    required this.imagem,
    required this.temVideo,
    this.concluido = false,
    this.expandido = false,
  });
}

// tela principal
class MenuTreino extends StatelessWidget {
  final UsuarioClass? user;
  final TipoPlanoClass? plan;

  const MenuTreino({super.key, this.user, this.plan});

  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          _buildInfoUsuario(),
          _buildDiasSemana(),
          _buildTiposTreino(context),
        ],
      ),
    );
  }

  Widget _buildInfoUsuario() {
    final Color lightOrange = const Color(0xFFFFF1E6);
    final Color orange = const Color(0xFFFF8C42);
    final Color grey = const Color(0xFF333333);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${plan?.nomePlano}',
                  style: GoogleFonts.poppins(
                      color: orange, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('${user?.login}',
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
                    Text("Treino: Professor da Academia",
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
                    boxShadow: [
                      if (isToday)
                        BoxShadow(
                          color: orange.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                    ],
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

  Widget _buildTiposTreino(BuildContext context) {
    final Color orange = const Color(0xFFFF8C42);
    final Color grey = const Color(0xFF333333);
    final Color lightOrange = const Color(0xFFFFF1E6);

    final List<Map<String, dynamic>> treinos = [
      {
        "tipo": "A",
        "icone": Icons.directions_run,
        "descricao": "Treino para Força",
        "tituloTreino": "PEITO / TRÍCEPS"
      },
      {
        "tipo": "B",
        "icone": Icons.fitness_center,
        "descricao": "Treino para Hipertrofia",
        "tituloTreino": "COSTAS / BÍCEPS"
      },
      {
        "tipo": "C",
        "icone": Icons.pool,
        "descricao": "Treino para Resistência",
        "tituloTreino": "PERNAS / PANTURRILHA"
      },
      {
        "tipo": "D",
        "icone": Icons.ac_unit,
        "descricao": "Treino para Definição",
        "tituloTreino": "OMBRO / ABDOMEN"
      },
    ];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: treinos.map((treino) {
            return InkWell(
              // abre os detalhes dos treinos
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (BuildContext context) {
                    return _TreinoDetalheSheet(titulo: treino['tituloTreino']);
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
                      Icon(treino['icone'], size: 40, color: orange),
                      const SizedBox(height: 8),
                      Text(
                        'Treino ${treino['tipo']}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: grey),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        treino['tituloTreino'],
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
          }).toList(),
        ),
      ),
    );
  }
}

class _TreinoDetalheSheet extends StatefulWidget {
  final String titulo;
  const _TreinoDetalheSheet({required this.titulo});

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

  late List<Exercicio> exercicios = [
    Exercicio(
        nome: "Supino Reto na barra",
        series: "4 x 10 a 12",
        imagem: "Assets/thumb-peito.png",
        temVideo: true),
    Exercicio(
        nome: "Crucifixo na Polia alta",
        series: "4 x 10 a 12",
        imagem: "Assets/thumb-peito.png",
        temVideo: true),
    Exercicio(
        nome: "Flexão Inclinada",
        series: "3 x 15",
        imagem: "Assets/thumb-peito.png",
        temVideo: true),
  ];

  // permite finalizar apenas se o treino comecou e todos os exercicios foram concluidos
  bool get podeFinalizar =>
      exercicios.every((ex) => ex.concluido == true) && treinoIniciado;


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
                  backgroundColor:
                  treinoIniciado ? Colors.grey : green,
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                      Text("Treino finalizado em $duracao"),
                      backgroundColor: green,
                    ),
                  );
                  Navigator.pop(context);
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  podeFinalizar ? red : Colors.grey.shade400,
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
              itemCount: exercicios.length,
              itemBuilder: (context, index) {
                final ex = exercicios[index];
                final bool isConcluido = ex.concluido;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: isConcluido ? 6 : 2,
                  color: isConcluido
                      ? lightOrange.withOpacity(0.8)
                      : Colors.white,
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
                            "${ex.nome} (${ex.series})",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              decoration: isConcluido
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: isConcluido
                                  ? grey.withOpacity(0.6)
                                  : grey,
                            ),
                          ),
                        ),
                        if (isConcluido)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child:
                            Icon(Icons.check_circle, color: green, size: 20),
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
                              child: Image.asset(ex.imagem, height: 150),
                            ),
                            const SizedBox(height: 8),
                            if (ex.temVideo)
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
