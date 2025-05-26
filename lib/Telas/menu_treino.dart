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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "PEITO / TRÍCEPS",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: _buildListaExercicios()),
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
              Text('${user?.login}', style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: lightOrange,
                  borderRadius: BorderRadius.circular(6),
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
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
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
    final tipos = ["PT", "CB", "PG", "PG", "OM", "-"];
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
                    child: Text(
                      tipos[index],
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: orange,
                      ),
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

  Widget _buildListaExercicios() {
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
    ];

    return ListView.builder(
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
                Icon(ex.temVideo ? Icons.chevron_right : Icons.chevron_right),
              ],
            ),
          ),
        );
      },
    );
  }
}
