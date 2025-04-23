import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/Telas/menu_comunidade.dart';
import 'menu_perfil.dart';
import 'menu_inicial_home.dart';
import 'package:projetosflutter/API/modelo_user.dart';
import 'menu_comunidade.dart';

class MenuInicial extends StatefulWidget {
  const MenuInicial({super.key});

  @override
  State<MenuInicial> createState() => _MenuInicialState();
}

class _MenuInicialState extends State<MenuInicial> {
  int _selectedIndex = 2;

  late UserClass _user;

  @override
  void initState() {
    super.initState();
    _user = UserClass();
  }

  List<Widget> get _pages => [
    MenuPerfil(user: _user),
    MenuComunidade(user: _user),
    MenuInicialHome(user: _user),
    const Placeholder(),
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
