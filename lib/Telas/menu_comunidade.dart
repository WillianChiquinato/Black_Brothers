import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';

import '../API/controller.dart';
import '../API/models/modelo_tipoPlano.dart';

class MenuComunidade extends StatefulWidget {
  final UsuarioClass? user;
  final TipoPlanoClass? plan;

  const MenuComunidade({super.key, this.user, this.plan});

  @override
  State<MenuComunidade> createState() => _MenuComunidadeState();
}

class _MenuComunidadeState extends State<MenuComunidade> {
  final Color lightOrange = const Color(0xFFFFF1E6);
  final Color orange = const Color(0xFFFF8C42);
  final Color grey = const Color(0xFF333333);

  late GenericController<UsuarioClass> _usuarioController;
  late UsuarioClass? usuario;
  late TipoPlanoClass? plano;

  @override
  void initState() {
    usuario = widget.user;
    plano = widget.plan;
    super.initState();
    _usuarioController = GenericController<UsuarioClass>(
      endpoint: 'Usuario',
      fromJson: (json) => UsuarioClass.fromJson(json),
    );
  }

  final List<Map<String, String>> historicoFalso = [
    {
      "data": "20/04/2025",
      "progresso": "Progresso de 10% no treino de pernas",
      "tempo": "Treino de 1h 15min",
    },
    {
      "data": "18/04/2025",
      "progresso": "Treino de costas e bíceps completo",
      "tempo": "Treino de 55min",
    },
    {
      "data": "15/04/2025",
      "progresso": "Início do plano alimentar com nutricionista",
      "tempo": "Dieta atualizada",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: grey,
          automaticallyImplyLeading: false,
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
            indicatorColor: orange,
            labelColor: orange,
            unselectedLabelColor: Colors.white,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'COMPARTILHAR'),
              Tab(text: 'HISTÓRICO'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCompartilharTab(),
            _buildHistoricoTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCompartilharTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Text(
            "QUER COMPARTILHAR SEU DASHBOARD?",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("COMPARTILHAR", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 40),
          Text(
            "CASO QUEIRA ATUALIZAR SEUS DADOS NO DASHBOARD,\nAPERTE AQUI",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text("ATUALIZAR DASHBOARD", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoricoTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: historicoFalso.length,
        itemBuilder: (context, index) {
          final item = historicoFalso[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: lightOrange,
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.history, color: orange),
              title: Text(
                item["progresso"]!,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${item["data"]} • ${item["tempo"]}",
                style: GoogleFonts.poppins(fontSize: 13),
              ),
            ),
          );
        },
      ),
    );
  }
}
