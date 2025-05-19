import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/models/modelo_tipoPlano.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';

class MenuFrequencia extends StatelessWidget {
  final UsuarioClass? user;

  const MenuFrequencia({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    final Color lightOrange = const Color(0xFFFFF1E6);
    final Color orange = const Color(0xFFFF8C42);
    final Color grey = const Color(0xFF333333);

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildTreinoCard(
                  horario: '14:30',
                  tipo: 'Aquecimento',
                  descricao: 'Manguito 2x, PeckDeck 3x 10',
                  duracao: '0h15min',
                  pontos: 3,
                  corIcone: orange,
                  icone: LucideIcons.thermometerSun,
                  tag: 'Hoje',
                  corTag: lightOrange,
                ),
                _buildTreinoCard(
                  horario: '16:15',
                  tipo: 'Treino - Completo',
                  descricao:
                  'Sup. Reto, Sup. Inclinado, PeckDeck,\nCruc. inclinado, Grac. na polia alta',
                  duracao: '1h30min',
                  pontos: 4,
                  corIcone: orange,
                  icone: LucideIcons.dumbbell,
                ),
                _buildTreinoCard(
                  horario: '17:00',
                  tipo: 'Cardio',
                  descricao: '45min na esteira',
                  duracao: '0h45min',
                  pontos: 1,
                  corIcone: orange,
                  icone: LucideIcons.heartPulse,
                ),
                Divider(height: 30),
                _buildTreinoCard(
                  horario: '14:30',
                  tipo: 'Aquecimento',
                  descricao: 'Manguito 2x, BarraFixa 3x 8',
                  duracao: '0h10min',
                  pontos: 0,
                  corIcone: orange,
                  icone: LucideIcons.thermometerSun,
                  tag: 'Ontem',
                  corTag: lightOrange,
                ),
                _buildTreinoCard(
                  horario: '16:10',
                  tipo: 'Treino - Completo',
                  descricao:
                  'Remada Articulada, Remada Baixa,\nPeckDeck Invert., Pulley Cima e baixo',
                  duracao: '1h30min',
                  pontos: 2,
                  corIcone: orange,
                  icone: LucideIcons.dumbbell,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreinoCard({
    required String horario,
    required String tipo,
    required String descricao,
    required String duracao,
    required int pontos,
    required Color corIcone,
    required IconData icone,
    String? tag,
    Color? corTag,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (tag != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                tag,
                style: TextStyle(
                  backgroundColor: corTag,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFDF7F2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(horario,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                Icon(icone, color: corIcone, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tipo,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(descricao,
                          style:
                          TextStyle(fontSize: 13, color: Colors.black54)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(duracao,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: Colors.amberAccent.shade700, size: 18),
                        Text(pontos.toString(),
                            style: TextStyle(fontSize: 13)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
