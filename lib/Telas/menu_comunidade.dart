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

  final List<Map<String, dynamic>> postsComunidade = [
    {
      "usuario": "GustavoPablo_fit",
      "horario": "2h atrás",
      "fotoPerfil": "Assets/UserIcon.png",
      "fotoPost": "Assets/legday.png",
      "legenda": "Treino de pernas concluído! Foco total nos ganhos. 🚀 #fitness #legday",
      "curtidas": 156,
    },
    {
      "usuario": "Lucia_Personal",
      "horario": "5h atrás",
      "fotoPerfil": "Assets/UserIcon.png",
      "fotoPost": "Assets/shake.png",
      "legenda": "Receita de shake proteico pós-treino: rápido e delicioso! 🥛💪",
      "curtidas": 305,
    },
  ];

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
                backgroundImage: AssetImage('Assets/UserIcon.png'),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Criar novo post! (Implementar navegação)")),
            );
          },
          backgroundColor: orange,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(post['fotoPerfil']),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['usuario'],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      post['horario'],
                      style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Image.asset(
            post['fotoPost'],
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 300,
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    "Imagem do Post não Encontrada",
                    style: GoogleFonts.poppins(color: Colors.grey[600]),
                  ),
                ),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                  },
                  color: grey,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "${post['curtidas']} curtidas",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 12.0),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(fontSize: 14, color: grey),
                children: [
                  TextSpan(
                    text: post['usuario'],
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: grey),
                  ),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: post['legenda'],
                    style: GoogleFonts.poppins(fontWeight: FontWeight.normal, color: grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompartilharTab() {
    return Container(
      color: lightOrange,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: postsComunidade.length,
        itemBuilder: (context, index) {
          return _buildPostCard(postsComunidade[index]);
        },
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