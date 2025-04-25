import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetosflutter/API/modelo_user.dart';

class MenuPerfil extends StatefulWidget {
  final UserClass user;

  const MenuPerfil({super.key, required this.user});

  @override
  State<MenuPerfil> createState() => _MenuPerfilState();
}

class _MenuPerfilState extends State<MenuPerfil> with TickerProviderStateMixin {
  late TabController _tabController;

  final lightOrange = const Color(0xFFFFF1E6);
  final orange = const Color(0xFFFF8C42);
  final grey = const Color(0xFF333333);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: grey,
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
                  widget.user.plano ?? 'Plano GOLD',
                  style: GoogleFonts.poppins(
                    color: orange,
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.user.nome ?? 'Renan Silva Pinheiro',
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
          controller: _tabController,
          indicatorColor: orange,
          labelColor: orange,
          unselectedLabelColor: Colors.white,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'DASHBOARD'),
            Tab(text: 'MEU PERFIL'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildPerfilTab(),
        ],
      ),
    );
  }

  Widget _buildPerfilTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Informações Pessoais"),
            const SizedBox(height: 12),
            _buildTextField("Nome", widget.user.nome ?? 'Renan Silva Pinheiro'),
            _buildTextField("Data de Nascimento", widget.user.idade ?? '30/05/2005'),
            _buildTextField("CPF", "000.000.000-00"),
            _buildTextField("Telefone", "(11) 95919-7939"),
            _buildTextField("Email", "renansilvapinheiro22@gmail.com"),
            const SizedBox(height: 24),
            _buildSectionTitle("Informações Físicas"),
            const SizedBox(height: 12),
            _buildTextField("Altura", widget.user.idade ?? '1.80m'),
            _buildTextField("Peso", widget.user.idade ?? '60.6 Kg'),
            const SizedBox(height: 28),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                ),
                child: Text(
                  "SALVAR ALTERAÇÕES",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: orange, width: 8),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.fitness_center, size: 36, color: Colors.black),
                      Text("100%", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("Média", style: GoogleFonts.poppins(color: grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDashboardIcon(Icons.calendar_month, "100%"),
                  _buildDashboardIcon(Icons.message_outlined, "100%"),
                  _buildDashboardIcon(Icons.bar_chart, "100%"),
                  _buildDashboardIcon(Icons.accessibility_new, "100%"),
                ],
              ),
              const SizedBox(height: 24),
              _buildStatusCard("PESO:", "MÉDIO", "Precisa alinhar sua dieta para ter um aumento de peso", orange),
              const SizedBox(height: 16),
              _buildStatusCard("Gordura Corporal:", "ELEVADO", "Se alimente e treine melhor para mudar esse quadro", Colors.redAccent),
              const SizedBox(height: 24),
              _buildCorpoResumo(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardIcon(IconData icon, String value) {
    return Column(
      children: [
        Icon(icon, size: 32, color: grey),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }

  Widget _buildStatusCard(String titulo, String nivel, String mensagem, Color cor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightOrange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 60,
            color: cor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text(nivel, style: GoogleFonts.poppins(color: cor, fontWeight: FontWeight.bold)),
                Text(mensagem, style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorpoResumo() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("${widget.user.idade ?? '1.80'}m", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text("Altura", style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Text("${widget.user.idade ?? '60.6'} Kg", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text("Peso", style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Text("${widget.user.idade ?? '48'} Kg", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text("Massa Magra", style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
            Column(
              children: [
                Text("${widget.user.idade ?? '37'}%", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text("Gordura", style: GoogleFonts.poppins(fontSize: 12)),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        initialValue: initialValue,
        style: GoogleFonts.poppins(),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(),
          filled: true,
          fillColor: lightOrange,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: grey,
      ),
    );
  }
}
