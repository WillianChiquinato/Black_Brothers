import 'package:flutter/cupertino.dart';
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

  Exercicio({
    required this.nome,
    required this.series,
    required this.imagem,
    required this.temVideo,
  });
}

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
            _drawerItem(Icons.person_outline, 'Nutricionista', context),
            _drawerItem(Icons.restaurant_menu, 'Consultar Dieta', context),
            _drawerItem(Icons.fitness_center, 'Treinos', context),
            _drawerItem(Icons.settings, 'Configurações', context),
            const Divider(),
            _drawerItem(Icons.exit_to_app, 'Sair', context),
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

  ListTile _drawerItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: GoogleFonts.poppins()),
      onTap: () => Navigator.pop(context),
    );
  }
  Widget _buildInfoUsuario() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${plan?.nomePlano}', style: GoogleFonts.poppins(
                color: orange,
                fontWeight: FontWeight.bold,
              )),
              SizedBox(height: 4),
              Text('${user?.login}', style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )),

              SizedBox(height: 18),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: lightOrange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.fitness_center, size: 16, color: orange),
                    SizedBox(width: 4),
                    Text("Treino: Professor da Academia", style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: grey,
                    )),
                  ],
                ),
              ),

              SizedBox(height: 12),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: grey),
                    SizedBox(width: 4),
                    Text("30/04/2024 - 30/08/2024", style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: grey,
                    )),

                    SizedBox(height: 20),
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
    final dias = ["Sex", "Sab", "Dom", "Seg", "Ter", "Qua"];
    final datas = ["12", "13", "14", "15", "16", "17"];
    final diaAtual = "17";

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dias.length,
        itemBuilder: (context, index) {
          final bool isToday = datas[index] == diaAtual;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isToday ? orange : lightOrange,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (isToday)
                    BoxShadow(
                      color: orange.withOpacity(0.3),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                ],
              ),
              width: 58,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dias[index],
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isToday ? Colors.white : grey,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    datas[index],
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isToday ? Colors.white : grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: isToday ? Colors.white : orange.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTiposTreino(BuildContext context) {
    final List<Map<String, dynamic>> treinos = [
      {"tipo": "A", "icone": Icons.directions_run, "descricao": "Treino para Força", "tituloTreino": "PEITO / TRÍCEPS"},
      {"tipo": "B", "icone": Icons.fitness_center, "descricao": "Treino para Hipertrofia", "tituloTreino": "COSTAS / BÍCEPS"},
      {"tipo": "C", "icone": Icons.pool, "descricao": "Treino para Resistência", "tituloTreino": "PERNAS / PANTURRILHA"},
      {"tipo": "D", "icone": Icons.ac_unit, "descricao": "Treino para Definição", "tituloTreino": "OMBRO / ABDOMEN"},
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
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (BuildContext context) {
                    return _buildListaExerciciosSheet(treino['tituloTreino']);
                  },
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(treino['icone'], size: 48, color: orange),
                    const SizedBox(height: 8),
                    Text(
                      'Treino ${treino['tipo']}',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      treino['descricao'],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildListaExerciciosSheet(String titulo) {
    final List<Exercicio> exercicios = [
      Exercicio(
        nome: "Supino Reto na barra",
        series: "4 x 10 a 12",
        imagem: "Assets/thumb-peito.png",
        temVideo: true,
      ),
      Exercicio(
        nome: "Crucifixo na Polia alta",
        series: "4 x 10 a 12",
        imagem: "Assets/thumb-peito.png",
        temVideo: false,
      ),
      Exercicio(
        nome: "Flexão Inclinada",
        series: "3 x 15",
        imagem: "Assets/thumb-peito.png",
        temVideo: true,
      ),
    ];

    return Container(
      height: 600, // ajustar a altura se necessário
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              titulo,
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: exercicios.length,
              itemBuilder: (context, index) {
                final ex = exercicios[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Checkbox(value: false, onChanged: (_) {}),
                        Image.asset(ex.imagem, height: 50),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ex.nome, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                              Text(ex.series, style: GoogleFonts.poppins(color: Colors.grey[600])),
                            ],
                          ),
                        ),
                        Icon(ex.temVideo ? Icons.smart_display : Icons.chevron_right),
                      ],
                    ),
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