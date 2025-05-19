import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/models/modelo_tipoPlano.dart';
import 'package:projetosflutter/Telas/menu_comunidade.dart';
import 'package:projetosflutter/Telas/menu_frequencia.dart';
import '../API/controller.dart';
import '../API/models/modelo_menu.dart';
import 'menu_perfil.dart';
import 'menu_inicial_home.dart';
import 'package:projetosflutter/API/models/modelo_usuario.dart';
import 'menu_comunidade.dart';

class MenuInicial extends StatefulWidget {
  const MenuInicial({super.key});

  @override
  State<MenuInicial> createState() => _MenuInicialState();
}

class _MenuInicialState extends State<MenuInicial> {
  int _selectedIndex = 2;
  late GenericController<MenuInicialResponse> _menuController;
  MenuInicialResponse? menuData;

  void initState() {
    super.initState();

    _menuController = GenericController<MenuInicialResponse>(
      endpoint: 'menu_inicial',
      fromJson: (json) => MenuInicialResponse.fromJson(json),
    );

    carregarDadosMenu(2);
  }

  Future<void> carregarDadosMenu(int id) async {
    try {
      final response = await _menuController.getOne(id.toString());

      print("API: " + response.toString());

      menuData = response;

      print(menuData?.usuario);
      print(menuData?.plano);
      setState(() {});
    } catch (e) {
      print('Erro ao buscar dados do menu: $e');
    }
  }

  List<Widget> get _pages => [
    MenuPerfil(user: menuData?.usuario, plan: menuData?.plano),
    MenuComunidade(user: menuData?.usuario, plan: menuData?.plano),
    MenuInicialHome(user: menuData?.usuario, plan: menuData?.plano),
    MenuFrequencia(user: menuData?.usuario),
    const Placeholder(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const lightOrange = Color(0xFFFFF1E6);
    const orange = Color(0xFFFF8C42);
    const grey = Color(0xFF333333);

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
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Comunidade'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Frequência'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Treino'),
        ],
      ),
    );
  }
}
