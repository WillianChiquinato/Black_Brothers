import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/models/modelo_aluno.dart';
import 'package:projetosflutter/API/models/modelo_planos.dart';
import 'package:projetosflutter/API/models/modelo_tipoPlano.dart';
import 'package:projetosflutter/Telas/menu_comunidade.dart';
import 'package:projetosflutter/Telas/menu_frequencia.dart';
import 'package:projetosflutter/Telas/menu_treino.dart';
import '../API/controller.dart';
import 'menu_perfil.dart';
import 'menu_inicial_home.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';
import 'menu_comunidade.dart';

class MenuInicial extends StatefulWidget {
  final int idUsuario;

  const MenuInicial({super.key, required this.idUsuario});

  @override
  State<MenuInicial> createState() => _MenuInicialState();
}

class _MenuInicialState extends State<MenuInicial> {
  int _selectedIndex = 2;
  late GenericController<AlunoClass> _alunoController;
  late List<AlunoClass> alunoData = [];
  late GenericController<UsuarioClass> _usuarioController;
  UsuarioClass? userData;
  late GenericController<PlanoClass> _planoController;
  PlanoClass? planoData;
  late GenericController<TipoPlanoClass> _tipoPlanoController;
  TipoPlanoClass? tipoPlanoData;

  List<Map<String, String>> _dadosExibicao = [];
  bool _carregando = true;

  void initState() {
    super.initState();

    _alunoController = GenericController<AlunoClass>(
      endpoint: 'Aluno',
      fromJson: (json) => AlunoClass.fromJson(json),
    );

    _usuarioController = GenericController<UsuarioClass>(
      endpoint: 'Usuario',
      fromJson: (json) => UsuarioClass.fromJson(json),
    );
    _planoController = GenericController<PlanoClass>(
      endpoint: 'Plano',
      fromJson: (json) => PlanoClass.fromJson(json),
    );
    _tipoPlanoController = GenericController<TipoPlanoClass>(
      endpoint: 'Tipo_Plano',
      fromJson: (json) => TipoPlanoClass.fromJson(json),
    );

    print(widget.idUsuario);
    _carregarDadosDoAlunoLogado(widget.idUsuario);
  }

  Future<void> _carregarDadosDoAlunoLogado(int idUsuario) async {
    final alunos =
        await _alunoController.getByQuery('FK_Usuario_ID=$idUsuario');

    if (alunos.isNotEmpty) {
      final aluno = alunos.first;

      if (aluno.FK_Usuarios_ID != null) {
        final usuario =
            await _usuarioController.getOne(aluno.FK_Usuarios_ID.toString());

        TipoPlanoClass? tipoPlano;

        if (aluno.FK_Planos_ID != null) {
          final plano =
              await _planoController.getOne(aluno.FK_Planos_ID.toString());

          if (plano != null && plano.Fk_TipoPlano_ID != null) {
            tipoPlano = await _tipoPlanoController
                .getOne(plano.Fk_TipoPlano_ID.toString());
          }
        }

        setState(() {
          userData = usuario;
          tipoPlanoData = tipoPlano;
          _carregando = false;
          print("Usuário: ${userData?.login}");
          print("Plano: ${tipoPlanoData?.nomePlano}");
        });
      } else {
        print('FK_Usuarios_ID do aluno é null');
        setState(() => _carregando = false);
      }
    } else {
      print('Nenhum aluno encontrado para o ID de usuário $idUsuario');
      setState(() => _carregando = false);
    }
  }

  List<Widget> get _pages => [
        MenuPerfil(user: userData, plan: tipoPlanoData),
        MenuComunidade(user: userData, plan: tipoPlanoData),
        MenuInicialHome(user: userData, plan: tipoPlanoData),
        MenuFrequencia(user: userData),
        MenuTreino(user: userData, plan: tipoPlanoData),
        const Placeholder(),
      ];

  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuFrequencia(user: userData),
        ),
      ).then((_) {
        // Esta função será chamada quando voltar da tela de frequência
        // Você pode forçar uma reconstrução se necessário
        setState(() {});
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const lightOrange = Color(0xFFFFF1E6);
    const orange = Color(0xFFFF8C42);
    const grey = Color(0xFF333333);

    if (_carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: orange,
        unselectedItemColor: grey.withOpacity(0.5),
        backgroundColor: lightOrange,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.poppins(),
        unselectedLabelStyle: GoogleFonts.poppins(),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), label: 'Comunidade'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Frequência'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Treino'),
        ],
      ),
    );
  }
}
